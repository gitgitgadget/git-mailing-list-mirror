From: Jared Hance <jaredhance@gmail.com>
Subject: [RFC] struct *_struct
Date: Wed, 4 Aug 2010 11:08:43 -0400
Message-ID: <20100804150843.GA2762@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 04 17:08:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgfaT-0006kP-0C
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 17:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758230Ab0HDPIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 11:08:51 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56794 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758208Ab0HDPIv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 11:08:51 -0400
Received: by vws3 with SMTP id 3so4177727vws.19
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 08:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=BeIt7JR0mTD66os5x7jNJfbyIe6g1FdKKIm//TZVa+A=;
        b=Kd8qhxEymmWv43jW6BaOSqNl9SkfuTV8AS6wWAClSkLtZZiPE0Dj45bWbx64oy9H58
         QXjK/ULjjyHiOpbnkKMSLGTWgzSo7bVF1SLSto8SNcfBr9kbvvNpdPpvzGkIgXG6w020
         og0MmZCqjwbb6RJBs5K0Di0koOPSRTohHRePo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=aUMaxi8nomfsMIUBWQVCG/KoW7sCHtKD8lYojF+fhhStH+EZIxc+TrFPr5AVKm1zWZ
         RDHyU8ZWRqhkp4EkY/F8JXb718zpaSUMyE9YZP16kLGW0U7jIpyhHshOGP9rXGNTT4bM
         l0WMqJ343AWtKIVXEj3/ksqnX/aOj9rCob640=
Received: by 10.220.62.72 with SMTP id w8mr6351020vch.72.1280934530177;
        Wed, 04 Aug 2010 08:08:50 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-101-209-27.cinci.res.rr.com [174.101.209.27])
        by mx.google.com with ESMTPS id s29sm4035182vcr.47.2010.08.04.08.08.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Aug 2010 08:08:49 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152583>

After browsing some of the diff related code today, I noted the
structure "struct diff_queue_struct". I found it somewhat odd that a
struct had struct in the name of the struct, and I hadn't really seen
any others like this.

Indeed, there are two others: struct dir_struct and struct cmd_struct.

To see, you can run:

    $ git grep _struct *.c *.h


Typing "struct *_struct" is rather verbose - We already have to
prepend the "struct", so it is extremely clear that we are using a
struct. Is there a reason that:

    - We are extremely verbose
    - We use this style in only 3 cases
