From: BJ Hargrave <bj@bjhargrave.com>
Subject: Re: [PATCH] Support empty blob in fsck --lost-found
Date: Sun, 11 Sep 2011 17:43:32 -0400
Message-ID: <348F09EE-5EE2-4F3E-B1B1-6FD34BDBD117@bjhargrave.com>
References: <A3964281-B24B-46C0-AE73-0CCB4C12556F@bjhargrave.com> <7vty8iolnj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 11 23:43:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2roU-0005v7-0Q
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 23:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755228Ab1IKVng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 17:43:36 -0400
Received: from mail-gw0-f42.google.com ([74.125.83.42]:45007 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754734Ab1IKVng convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2011 17:43:36 -0400
Received: by gwb17 with SMTP id 17so3407445gwb.1
        for <git@vger.kernel.org>; Sun, 11 Sep 2011 14:43:35 -0700 (PDT)
Received: by 10.236.200.195 with SMTP id z43mr22126525yhn.127.1315777415287;
        Sun, 11 Sep 2011 14:43:35 -0700 (PDT)
Received: from macbookpro2.hargrave.local (106.27.205.68.cfl.res.rr.com [68.205.27.106])
        by mx.google.com with ESMTPS id y79sm8788028yhg.23.2011.09.11.14.43.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Sep 2011 14:43:34 -0700 (PDT)
In-Reply-To: <7vty8iolnj.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181198>


On Sep 11, 2011, at 16:43 , Junio C Hamano wrote:

> Funny.
> 
> I am sure we fixed a similar breakage elsewhere a few years ago, by
> swapping the size and nmemb to the calls (i.e. instead of writing one
> block of "size" bytes, you could write "size" blocks of 1-byte) and making
> sure fwrite() reports the number of items. IOW
> 
> 	if (buf && fwrite(buf, 1, size, f) != size)
> 		die_errno("Could not write '%s'", filename);
> 

Do you want me to resubmit the patch using this technique instead of the size > 0 check?
-- 

BJ
