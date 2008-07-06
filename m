From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: Git, merging, and News/Relnotes files
Date: Sun, 6 Jul 2008 18:53:42 +0400
Message-ID: <37fcd2780807060753h26d9391crff5f9ba5531db654@mail.gmail.com>
References: <g4n7j6$359$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 16:54:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFVdQ-0003H1-PS
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 16:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756774AbYGFOxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 10:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756736AbYGFOxn
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 10:53:43 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:29553 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756019AbYGFOxm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 10:53:42 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1780158wfd.4
        for <git@vger.kernel.org>; Sun, 06 Jul 2008 07:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fXeW5tDXRb2gAYOQJdajg0biTtgOrgGWDUX/OO8KEy0=;
        b=JU6rQH2AfyDuB1s0WEp0JPvbPTgR/NZ4PyuYftejTi/S3c/IOS/5taFN/xXjYfbdcC
         wqQYgbGPp2s1rCoYEOxHGK0+pzptq/e5UHBHy3Q1qAE3wA78tsICVgHcAeVEBu2e/T7/
         stKeq+at+fTFUcW5Evk7M9v2nRyMuR1EkYeIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=VW8j1Eq0phxNIyMo2jxCZKMn7mpPVB4zLNunVPL3Q80QnmrgipQV0me/dF9WI0vHIE
         +i/Q4IgrsgWhzVOafcRb8UWECcru0LMtZ7BO/V9AgpiUkJOLbb2aXOdUxUbWO+WPtkGt
         aYyIUWO/2Yulc7eGM+h/jmv/Z8gxqH3wj0sbk=
Received: by 10.143.17.5 with SMTP id u5mr951507wfi.98.1215356022417;
        Sun, 06 Jul 2008 07:53:42 -0700 (PDT)
Received: by 10.143.32.3 with HTTP; Sun, 6 Jul 2008 07:53:42 -0700 (PDT)
In-Reply-To: <g4n7j6$359$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87534>

On Sat, Jul 5, 2008 at 11:24 AM, Edward Z. Yang
<edwardzyang@thewritingpot.com> wrote:
> As a policy on a project that I manage, almost every commit warrants a
> change to our NEWS (changelog) file, which end-users can browse to get
> an in-depth idea of the changes that have happened from the last
> release. If it's an added feature, the changelog includes a description
> of how to use it; if it's a fixed bug, it briefly describes what
> happened. Internal changes may or may not get added, depending on the
> visibility of the APIs affected.

I believe it is better to put all this information directly to the commit
message using some special tagging, so you can extract it automatically
at the release time and generate the changelog file for users. You may
edit the generated changelog and commit it directly before release.

Having one file changed on almost every commit is not a good idea, and
not only because it will cause unnecessary conflicts but also it may
considerable increase the size of the whole repository. By default, the
delta compression has limit 50, which means that every 50 change of file
will become its full copy. If the changelog file is changed very often
and it is long, it may turn out that changelog alone takes as much space
as the rest of the source tree.

Dmitry
