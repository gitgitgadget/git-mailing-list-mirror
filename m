From: David Ware <davidw@realtimegenomics.com>
Subject: Re: BUG: git subtree split gets confused on removed and readded directory
Date: Mon, 18 Jan 2016 08:34:16 +1300
Message-ID: <CAET=KiXJ4tkryy_UNWtD3dRSXXpBfL=7ZS5GNivmGi0Yx7Rv4A@mail.gmail.com>
References: <56991CFC.7060705@ruhr-uni-bochum.de>
	<xmqq4meeflws.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "David A. Greene" <greened@obbligato.org>, git@vger.kernel.org,
	Marcus Brinkmann <marcus.brinkmann@ruhr-uni-bochum.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 20:34:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKt5i-0000fw-Nd
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jan 2016 20:34:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbcAQTeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 14:34:18 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:35990 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291AbcAQTeR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 14:34:17 -0500
Received: by mail-vk0-f48.google.com with SMTP id n1so167479849vkb.3
        for <git@vger.kernel.org>; Sun, 17 Jan 2016 11:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=realtimegenomics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=r3+DMTiS6mitxTiL0jgKcYHWOb68IBOaXQ+4YY8xFuY=;
        b=I93iuAYjYSz1l0zFEQ6IXZDydZdVsDqCON0/RdoMYH90VvpfTqWznt2ofubbWGu93p
         Ok1MX2nl+NJ/3WhQ84J1A71KLRben1kSOaFm6xOosZ/P1/mbyz9PtOtbT/Jbf2F33Qa0
         ugpQF7vrwu6cruM6dGQr8/Hye1fzkh0lC/mD14a+FhgALHRYeV28HCSURU/CAkKsjosQ
         p/9ODSNNT4z3+mga9mh0rmfKs4ZzBzNs12XmPvYXptEozeMOZ1Z9lf6o1IDOtqlQOTWF
         DboMVwIs/EgZlfirM1L1L/P6FGQZl1BfcV2AUP8o6IHjAzLv8dpkbHKkDT75ILWQly7G
         j8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=r3+DMTiS6mitxTiL0jgKcYHWOb68IBOaXQ+4YY8xFuY=;
        b=XzL/ql/jjjCanHo2ZFLiafB7iXavBmK+GjihUoh413copuG1NkmHt68itdf61tXhGe
         J3vUmUVQfP5HBxMAWezPuOE8gxDttcUWCUcaIFN7a2rnNMAnBwyN1i8w2TzAXRJQHqXj
         gjfuHaoBs6lOsAFa9fqUcR/8ohFrJcCQnti5vgnoSyiMXrJJPT/WFCFh0w2vfSiXAPKM
         Gq7MjruhBZNFzEKLVcZg9P5sU8Nua7HmhQ+E8tgDdbwUdBV2cB0Uo+7zmaJO317yUx8A
         Mb3zJzfTiqQoVj1QG8a1Xo/AHqOEndri8p+7/IDt92Ie0uZXyRc5h7DwJzqFTAgeqIWS
         +log==
X-Gm-Message-State: ALoCoQka/q2aZGdTP7oX+iR2SoMsZaLBJZc5yityVZWYHbVZFcWQjG3h9ub3ShZThtrPqaaueYPs4llEyvIgKTe7CAHhwKxNA2HlkuCAZTnKTieHF96RQe0=
X-Received: by 10.31.185.196 with SMTP id j187mr12886899vkf.99.1453059256320;
 Sun, 17 Jan 2016 11:34:16 -0800 (PST)
Received: by 10.31.161.206 with HTTP; Sun, 17 Jan 2016 11:34:16 -0800 (PST)
In-Reply-To: <xmqq4meeflws.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284265>

No my patch doesn't seem to fix this.

Cheers,
Dave Ware

(sorry if you're receiving this for the second time, I'm resending
since the mailing list blocked my earlier reply for html content)

On Sat, Jan 16, 2016 at 12:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Marcus Brinkmann <marcus.brinkmann@ruhr-uni-bochum.de> writes:
>
>> I made a simple test repository showing the problem here:
>> https://github.com/lambdafu/git-subtree-split-test
>>
>> After creating the master branch, I created the split/bar branch like this:
>>
>> $ git subtree split -P bar -b split/bar
>>
>> The resulting history is confused by the directory "bar" which was
>> added, removed and then re-added again.  The recent history up to adding
>> the directory the second time is fine.  But then it seems to loose track
>> and add the parent of that commit up to the initial commit in the history.
>>
>> I'd expect that the parent of the readding commit is an empty tree
>> commit (which removed the last files in the directory), and that before
>> that are commits that reflect the initial creation of that directory
>> with its files, but rewritten as a subtree, of course.
>
> Thanks for a report.
>
> David, does this ring a bell?
>
> Dave, does your fix "subtree split" we saw recently on the list
>
>     http://article.gmane.org/gmane.comp.version-control.git/284125
>
> help this?
