From: Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH v5 1/1] send-email: Add sendmail email aliases format
Date: Mon, 25 May 2015 08:47:32 -0400
Message-ID: <CAJ80sas_D-6z4MvuFvvjoX7U_bM6b3brCo4rvYFCUfTmKS=6bA@mail.gmail.com>
References: <49e9a95b52aa61ed4f37edf1dfa178186acb4a29.1432367540.git.allenbh@gmail.com>
	<xmqqfv6nchmf.fsf@gitster.dls.corp.google.com>
	<xmqq382ncgmb.fsf@gitster.dls.corp.google.com>
	<CAJ80savVjb3_iKhNWPjQNK72DL7eq5YkbjWWG-1Gkx5+LOjzeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 25 14:47:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwrnI-0002Mz-HX
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 14:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbbEYMrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 08:47:35 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37426 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608AbbEYMrd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 08:47:33 -0400
Received: by wibt6 with SMTP id t6so48100745wib.0
        for <git@vger.kernel.org>; Mon, 25 May 2015 05:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=h9FLjLeQpnhOJd04MncUHaEaSIfBeIJ3zufH+33O7fc=;
        b=kPaMT8yq2Qca+XMM8hQZKjo8iTzzFep5Z8tlEvSNqq2+u16B6Zwdkybn+OVFHWB7Ft
         L2iKNOBYOAtx7sT0rXwGhlYmgT0YJcouc0T75kiKrh/qaqMAjXcexSgB102yvnX+qq3j
         AjXjyqaXDyQXp2gTHRLSFUpT4MuQXK+aSZBAOqeYmLIg8RCFoXrzQZ4OQphc0BOiAgeY
         Sw8TfdLB+ugziXpvlQgzL1913taoSpaMpOOALvF3mqbn4s7MEfHd6/IsSvY1y8WRcBwE
         spREHb8n1jeweNWUPhMnI/aqAWd6LBA5nUaU4E22UOcxAsZ4WrtMoJuefWPR8rJq+cwi
         8f8g==
X-Received: by 10.180.89.234 with SMTP id br10mr8225471wib.86.1432558052139;
 Mon, 25 May 2015 05:47:32 -0700 (PDT)
Received: by 10.28.59.4 with HTTP; Mon, 25 May 2015 05:47:32 -0700 (PDT)
In-Reply-To: <CAJ80savVjb3_iKhNWPjQNK72DL7eq5YkbjWWG-1Gkx5+LOjzeg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269839>

On Sat, May 23, 2015 at 6:24 PM, Allen Hubbe <allenbh@gmail.com> wrote:
> On Sat, May 23, 2015 at 2:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> A small thing I noticed in the test (and this patch is not adding a
>>> new "breakage"---there are a few existing instances) is the use of
>>> "~/"; it should be spelled "$HOME/" instead for portability (not in
>>> POSIX, even though bash, dash and ksh all seem to understand it).
>>
>> Well, I was wrong. Tilde expansion is in POSIX.
>>
>> Nevertheless, I'd prefer if we avoided it.
>
> Alright, $HOME it will be.

Looking closer at this and the other test cases, they are inconsistent
about using ".mailrc", "~/.mailrc", and "$(pwd)/.mailrc".  This would
add another one, "$HOME/.mailrc".

How do you feel about using just ".mailrc", and "$(pwd)/.mailrc" when
an absolute path is needed in gitconfig?
