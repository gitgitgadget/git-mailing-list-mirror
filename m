From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Fri, 12 Dec 2008 23:13:27 +0700
Message-ID: <fcaeb9bf0812120813m2949e36ar7905d5688b8f6ecb@mail.gmail.com>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>
	 <fcaeb9bf0812060926r2ee443bfl3adb3f2d1129e5b8@mail.gmail.com>
	 <alpine.LNX.1.00.0812061238260.19665@iabervon.org>
	 <fcaeb9bf0812070427s64438216s41bf1294aa6398a3@mail.gmail.com>
	 <alpine.LNX.1.00.0812071455020.19665@iabervon.org>
	 <fcaeb9bf0812080451k6e213d0fo8d1da9bbac872649@mail.gmail.com>
	 <alpine.LNX.1.00.0812081223140.19665@iabervon.org>
	 <fcaeb9bf0812110504u1acfb612he3edae1df3774045@mail.gmail.com>
	 <alpine.LNX.1.00.0812111520490.19665@iabervon.org>
	 <7vy6ym9nm8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Daniel Barkalow" <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 17:14:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBAfA-0005Jv-G4
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 17:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757296AbYLLQNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 11:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757521AbYLLQNa
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 11:13:30 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:63680 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757133AbYLLQN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 11:13:29 -0500
Received: by fg-out-1718.google.com with SMTP id 19so733332fgg.17
        for <git@vger.kernel.org>; Fri, 12 Dec 2008 08:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=k4AA9qN1nh/49byMdtweSi4YGP3ax2b8O91Vrr9Ofow=;
        b=RwKirHCUHSMBRk0oRwc7vUdJ/a/zb4ttlyEPpXuFebjY0YCaxMKF0axVgCfSZR88T8
         q129szzyi2LNrbRHjTNGOesbuvtUhAbWs14oJKvLgsYPfMb3AbWhm1ELkN/S4uwJpwqX
         WlmZ3YB7I/yASRCB8ydupGsRKMVlfq6t7UXAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AoPySJyevzNp7uvi+lPAc+oq49O3XaT2hjO9tOGQ17kZJ4OpY1mpsl2x4N04CqRwlM
         pNKh8CRfz5Wq97pFE+IZNqs3KeDGFUG1W2zLbcE3HwnmVxIMMfd2JydmZhissHTKPMQT
         pmTGSrk9z02cGeJw5xBWOPotzb+SVE+PkIObE=
Received: by 10.86.63.19 with SMTP id l19mr2131024fga.57.1229098408106;
        Fri, 12 Dec 2008 08:13:28 -0800 (PST)
Received: by 10.86.87.14 with HTTP; Fri, 12 Dec 2008 08:13:27 -0800 (PST)
In-Reply-To: <7vy6ym9nm8.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102912>

On 12/12/08, Junio C Hamano <gitster@pobox.com> wrote:
>  So "git grep -e frotz Documentation/", whether you only check out
>  Documentation or the whole tree, should grep only in Documentation area,
>  and "git grep -e frotz" should grep in the whole tree, even if you happen
>  to have a sparse checkout.  By definition, a sparse checkout has no
>  modifications outside the checkout area, so whenever grep wants to look
>  for strings outside the checkout area it should pretend as if the same
>  content as what the index records is in the work tree.  This is consistent
>  with the way how "git diff" in a sparsely checked out work tree should
>  behave.

Assume someone is using sparse checkout with KDE git repository. They
sparse-checkout kdeutils module and do "git grep -e foo". I would
expect that the command only searches in kdeutils only (and is the
current behavior).
-- 
Duy
