From: Stefan Karpinski <stefan.karpinski@gmail.com>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Mon, 6 Apr 2009 18:36:06 -0700
Message-ID: <d4bc1a2a0904061836t295d5cf8w39500d63acfc80ab@mail.gmail.com>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com> 
	<200904052358.53028.markus.heidelberg@web.de> <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com> 
	<200904060117.24810.markus.heidelberg@web.de> <fabb9a1e0904051622k66352ea4v542ecd99bd5d9c6@mail.gmail.com> 
	<20090406032457.GA14758@gmail.com> <7v63hie4yh.fsf@gitster.siamese.dyndns.org> 
	<871vs5kjfw.fsf@krank.kagedal.org> <7vy6ud4otd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	markus.heidelberg@web.de,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 03:38:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr0GE-0007FB-5Y
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 03:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbZDGBgY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 21:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbZDGBgY
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 21:36:24 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:53624 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbZDGBgX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2009 21:36:23 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2518800wff.4
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 18:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XU/OF84rAOt+qjflQCOLojnbnkEQLerTE6yZOtx8Zoc=;
        b=lfd2+P2s4KgRpaZ+W47xKzCBTDx8/5F0lBl6SKBR5y86JcFg0+cNBTWJok5aVpr5Z1
         vhl88GBTyadrblpcrFzfAJPF4Pg2O0ksctvAHGldwW/4iDcFfrOpGmMc4kB6hj1tzrQV
         T+bEz8acE/NIvL4WJ9UT1HBj6ShBCd23z/O+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=amtFAcij5syBovfhEvBzTVddKVcI9JCsJUw+Uoht8WpaXIFCyH3QH1qhKe96jtyiKU
         JBYTH8Be2xkswPqffu6IjoZr+td6CjW+HQxsP3foN+37wULAozgnAPXC+CDEFbUAcwG7
         ukM2J2oMekLGa4tLl4+Q1Z2j0YQOEsgKxpvaw=
In-Reply-To: <7vy6ud4otd.fsf@gitster.siamese.dyndns.org>
Received: by 10.142.155.9 with SMTP id c9mr1440371wfe.302.1239068181194; Mon, 
	06 Apr 2009 18:36:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115898>

On Mon, Apr 6, 2009 at 11:30 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> David K=E5gedal <davidk@lysator.liu.se> writes:
>
>> What do you mean? This was a suggestion for how git diff should
>> work. I fail to see how you would need a WORKTREEANDTHEINDEX there.
>
> You are talking only about "git diff". =A0I am talking about the whol=
e git
> suite, because you have to worry about how such a proposal would affe=
ct
> other parts of the UI.
>
> For example, what, if anything, should be done to "git grep --cached"=
 and
> "git apply --index"? =A0Leave them unchanged and only change "git dif=
f"?
>
>> I think this is a basic usability issue for a high-level porcelain
>> command such as diff.
>
> I do not think there is any usability issue. =A0Why do you think sayi=
ng
> STAGE in all capital makes it easier to _use_ instead of saying --cac=
hed
> (or --index-only)? =A0In either way, you need to understand the under=
lying
> concept, such as:

There is most definitely a usability issue here. I use git every day
and I *cannot* for the life of me remember all the inconsistent
stage-related oddball commands. I have a number of aliases for them
(similar to what Felipe is proposing) which are the only way I can
remember them. Whenever I find myself using a git repo without those
aliases, I have to fire up the man pages. Trying to explain all of
this to coworkers that use git=97honestly, I don't even try to go there=
=2E
