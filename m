From: Jerome Yanga <jerome.yanga@gmail.com>
Subject: Re: git push from client is not updating files on server
Date: Wed, 7 Mar 2012 07:43:46 -0800
Message-ID: <CAC0z1F_hvqmWO5k-3KCbGaEDBf_iadKaqPg0tj3iCrCar2mJ=A@mail.gmail.com>
References: <CAC0z1F-bGikXZtLnd8d=3G+4okvNqZaxyrLjh4G3YzPpmqyxQA@mail.gmail.com>
	<4F567DC6.4070903@gmail.com>
	<4F567FEF.5000105@gmail.com>
	<CAC0z1F_eyMo4D8E2j15dOFhp-6tZ_ixacB6XcKfNpJategcsXQ@mail.gmail.com>
	<CAC0z1F_LYRkReO1qqcjkWy6Vb3E0_oNo-0kSf15nGfQFAtXpdg@mail.gmail.com>
	<CAC0z1F87ORZQmrZeMGo2suV1fAt-5mAwwpkkV3ZTx0US3AjM8Q@mail.gmail.com>
	<4F569EA8.4050907@gmail.com>
	<CAC0z1F9sBYCuv_HMCx1ryWLvxZKUcLPS1UUj80ihEesje+SKzg@mail.gmail.com>
	<4F56C946.8080601@gmail.com>
	<4F5740AD.9080306@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 16:44:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5J1v-0007Tf-Lx
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 16:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758343Ab2CGPns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 10:43:48 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62350 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758013Ab2CGPnr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 10:43:47 -0500
Received: by vcqp1 with SMTP id p1so5482602vcq.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 07:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=efo1pbHBdftD1j/jAERnKzD0eaztKtgQb7xWdCVd0xc=;
        b=tYtHE4MzM+UVmX52j6bF3VocNyKDiKKzXdEA7tph8uafNvFJOf+v+jYPmGy8rrFnDv
         ti+hOHSEtCltprE1kgs1munH8gS0ccOpadbMYUBkzkfqLXOSUV2RRxMc+HGohsqkz+r3
         Y87p6+r7skTUmob2yNDJ8FpnGfouwSgIa8iYaNiTgAPF0eqwyn4bSSE1j7Peab28jsmB
         00eZscIbv6RIwPESzeTbaC7Q1vgu/p+8aIzv9DWvEU2jKca5AUHwZ/r9Z4Ij8YgE9XpP
         AdtDyMXK7aTNFiUF+aQWJN6PS/YhzJzNMWmQNmVIeIyPoRWf6VYsDWuUSQaLL3V0CssK
         Tg7A==
Received: by 10.52.26.176 with SMTP id m16mr3865398vdg.1.1331135026634; Wed,
 07 Mar 2012 07:43:46 -0800 (PST)
Received: by 10.220.5.210 with HTTP; Wed, 7 Mar 2012 07:43:46 -0800 (PST)
In-Reply-To: <4F5740AD.9080306@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192462>

Thank you all for the recommendations.  I will try them.

I would like to confirm some info.

Junio,

Your assumption of my setup correct.  I shall read on post-update
hook.  If you have a recommended link for it, please share it.

Neal,

You are also correct.  My current configuration's reaction to a push
shows that the bare repo that was cloned from a non-bare repo are
independent of each other.  I will also try your recommendation.

Holger,

Thank you for explaining what Neal meant.

Regards,
j

On Wed, Mar 7, 2012 at 3:04 AM, Holger Hellmuth <hellmuth@ira.uka.de> wrote:
> On 07.03.2012 03:34, Neal Kreitzinger wrote:
>>
>> Create a new non-bare clone of your bare repo. Then do git-pull on the
>> new non-bare after the bare gets updates (someone does git push to it)
>> and you want to test those new commits. The worktree of the new non-bare
>> clone can be the document root of your testing virtual host, if that's
>> what you're doing. That way, you know that no one else is messing with
>> new non-bare (test repo) like doing development in it and messing up
>> your tests.
>
>
> To expand on Neals method, if you do git fetch (periodically in a cron job
> for example) on the cloned non-bare, 'git log HEAD..origin/HEAD' will have
> output only if the non-bare has new commits.
>
>
