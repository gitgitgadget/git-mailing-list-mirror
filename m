From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Support tags in uncommit - use git_id instead of rev_parse
Date: Mon, 1 Oct 2007 23:00:52 +0100
Message-ID: <b0943d9e0710011500o1bd621a4q10dfe0468c8795e2@mail.gmail.com>
References: <20070930172647.18972.49369.stgit@tt.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Pavel Roskin" <proski@gnu.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 00:01:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcTKB-0007EZ-IN
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 00:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757499AbXJAWAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 18:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757441AbXJAWAz
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 18:00:55 -0400
Received: from nz-out-0506.google.com ([64.233.162.239]:60697 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757343AbXJAWAx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 18:00:53 -0400
Received: by nz-out-0506.google.com with SMTP id s18so2719008nze
        for <git@vger.kernel.org>; Mon, 01 Oct 2007 15:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=JrorGj9AeDWRhF+nehFjeHVu+bdTxSxUNisCbqMEKEk=;
        b=O7f8zKwSaARAkq/y+Z49mjK72F3j4DyP90uMDSLBJpfsEChxLWukShYfrISYCZbxabNP6tfZDhPWXXynkmc10gh+M9HYujSMrvK64+kKa6JIpqrPRCkqywtfKothGYBV+w6FpDr5naYPmkLms6I1ULZB5UGBjjt6qKF/XrtLCRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZRNfFiFmArDmxRBUk0J+rIBKjh8yGRM8qVYCN2yJXYAJ3HGUvK0DPu4TIVSnM93ktjarY3z/VENbcgfvphDAZ99kHV6a0FrFpFTXi65LFa0myt/kjbRo6vuPHjR2A1VTi3KWbcXSU57Ml1ilpFmKuMJlYrzNetohb1RhsF7f3ns=
Received: by 10.114.254.1 with SMTP id b1mr1328585wai.1191276052322;
        Mon, 01 Oct 2007 15:00:52 -0700 (PDT)
Received: by 10.140.187.15 with HTTP; Mon, 1 Oct 2007 15:00:52 -0700 (PDT)
In-Reply-To: <20070930172647.18972.49369.stgit@tt.roinet.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59637>

On 30/09/2007, Pavel Roskin <proski@gnu.org> wrote:
> Signed-off-by: Pavel Roskin <proski@gnu.org>

With this patch, uncommit can take patch names (with modifiers) as the
--to argument. When would this be needed?

To allow tags, maybe just pass something like
"git.rev_parse(options.to + '^{commit}')" or just modify git.rev_parse
to do it (and git_id to avoid it).

-- 
Catalin
