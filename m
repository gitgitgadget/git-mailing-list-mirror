From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 4/4] buitin-status: Add tests for submodule summary
Date: Fri, 14 Mar 2008 02:09:09 +0800
Message-ID: <46dff0320803131109j165cfde9v85ea9b04a05819ef@mail.gmail.com>
References: <1205416085-23431-1-git-send-email-pkufranky@gmail.com>
	 <1205416085-23431-2-git-send-email-pkufranky@gmail.com>
	 <1205416085-23431-3-git-send-email-pkufranky@gmail.com>
	 <1205416085-23431-4-git-send-email-pkufranky@gmail.com>
	 <1205416085-23431-5-git-send-email-pkufranky@gmail.com>
	 <47D93875.1050407@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 19:10:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZrsE-0007xB-LH
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 19:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbYCMSJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 14:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753844AbYCMSJL
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 14:09:11 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:61393 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbYCMSJK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 14:09:10 -0400
Received: by an-out-0708.google.com with SMTP id d31so842784and.103
        for <git@vger.kernel.org>; Thu, 13 Mar 2008 11:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=vgJQqN5Xl4bmeyYOXhz1DvSguvTC5HG/FbUsJZsBWco=;
        b=Qsb1MK8M0bzLiEwCA3TE4MYhhN1YXbEtvi4E+TrGRmGxsfMz1qh6m/Fkcmo5wHXlw94GYSagyIa1fD9H3B4bI0110gDik18DES9mZMlS1AcIl5w9Z72WwubaXwONB1tN3/Oa5SEP01FR0zyLL3l0waQZeenfHAvyX8hnkrjkfgs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oPW6tor2zsfhiDJ/Vblq4QY75CPeMR6NPqBBHbpfENZnc3EhY0so/dbdKreVY9leFgLmJFKuZle6qJBVpwSDw3l6AgZLyIyQWSRnEWB73C88Bullgi4dv769w0eX5kHyszX8vpVricTYMkZKTnLV9TdGXg5f+81tYMEnb+0Bxjw=
Received: by 10.100.207.5 with SMTP id e5mr3905003ang.95.1205431750136;
        Thu, 13 Mar 2008 11:09:10 -0700 (PDT)
Received: by 10.100.5.18 with HTTP; Thu, 13 Mar 2008 11:09:09 -0700 (PDT)
In-Reply-To: <47D93875.1050407@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77121>

On Thu, Mar 13, 2008 at 10:21 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Ping Yin schrieb:
>
> > +cd sm &&
>  > +head=$(git rev-parse --verify HEAD | cut -c1-7) &&
>  > +cd ..
>
>  I think you can make these three lines into:
>
>  test_expect_success 'get short SHA1 of submodule HEAD' '
>
>         head=$(cd sm && git rev-parse --verify HEAD | cut -c1-7)
>  '
>
>  (not tested, though).

Hmm, It doesn't work. Since i need $head1 outputed to file expect as follows

+cat > expect <<EOF
+# On branch master
+# Changes to be committed:
+#   (use "git reset HEAD^1 <file>..." to unstage)
+#
+#      new file:   dir2/added
+#      new file:   sm
+#
+# Changed but not updated:
+#   (use "git add <file>..." to update what will be committed)
+#
+#      modified:   dir1/modified
+#
+# Modified submodules:
+#
+# * sm 0000000...$head (1):

Here we need $head.



-- 
Ping Yin
