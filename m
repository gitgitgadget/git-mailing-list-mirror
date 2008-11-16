From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 07/11] gitweb: add 'remotes' action
Date: Sun, 16 Nov 2008 01:29:16 +0100
Message-ID: <200811160129.17319.jnareb@gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com> <200811151316.32024.jnareb@gmail.com> <cb7bb73a0811150432s2f3ae4bfkc0fc29d92accc635@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 01:30:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1VXP-0001dm-Nl
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 01:30:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbYKPA31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 19:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbYKPA31
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 19:29:27 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:11035 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbYKPA30 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 19:29:26 -0500
Received: by ey-out-2122.google.com with SMTP id 6so780281eyi.37
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 16:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=KK/q9ZhEyOG/q3FMit7ktjgfZuHXORsV4f3s1Kmn2zM=;
        b=gqA0dDKqeGf1XGAF1Rvb1pNHMi7gAgz5id6mFnNVJqcjwez3w7tqaxd1eNIaJvXD5O
         4ybWc/5vV03Kl5drBdnEknBbLHdj2HgYzZeLLAu/IM9L2cMKr/btzOWF8nykz/kWyeCn
         HXdEiZ/V/VaP8kAYDmyfl7xCuQUJzVbc8dTec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=XuXGkYdEfPVYkofU/c4uhnPrvnaMWqm5R3Pq5Ad1/j8SjHp9kKJoyk0xkRUkwO2bU+
         uxYROE+q6DjFqmOBdUBo+5WVS5TnHrrLT3YRoHxzgA7olPFm8grH2Q88lpce60vrCFfN
         ZMEeiwXEsaSQgNLUO5DVgd/D6sACyUAoiqMHg=
Received: by 10.210.66.13 with SMTP id o13mr770746eba.113.1226795363713;
        Sat, 15 Nov 2008 16:29:23 -0800 (PST)
Received: from ?192.168.1.11? (abwb4.neoplus.adsl.tpnet.pl [83.8.225.4])
        by mx.google.com with ESMTPS id 10sm1617460eyd.6.2008.11.15.16.29.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 Nov 2008 16:29:22 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0811150432s2f3ae4bfkc0fc29d92accc635@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101104>

On Sat, 15 Nov 2008, Giuseppe Bilotta wrote:
> On Sat, Nov 15, 2008 at 1:16 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Thu, 13 Nov 2008, Giuseppe "Oblomov" Bilotta wrote:
>>
>>> This action is similar to the 'heads' action, but it displays
>>> remote heads, grouped by remote repository.
>>
>> I think I would prefer would go together with the change that split
>> the 'heads' ('branches') part of summary view into 'heads' and
>> 'remotes', so that both section title header, and '...' continuation
>> if present, lead to proper view.
>>
>> So either
>>
>>  [heads]  # or [branches]
>>  master
>>  to-submit
>>  origin/master
>>  origin/next
>>  ...
>>
>> where both '[heads]' and (possibly) '...' link to 'heads' view showing
>> _both_ local branches (refs/heads/*) and remote-tracking branches
>> (refs/remotes/*), like in first patch of series (perhaps with some
>> subdivision).
>>
>> Or
>>
>>  [heads]
>>  master
>>  to-submit
>>  ...
>>  [remotes]
>>  origin/master
>>  origin/next
>>  ...
>>
>> where '[heads]' link to 'heads' view which shows only local branches
>> (refs/heads/*), and '[remotes]' link to 'remotes' view which shows only
>> remote-tracking branches.
> 
> That's funny, I just squashed this patch with the summary list split
> view patch 8-) I'm going for the second option, to have [heads] link
> to heads which only lists local heads, and [remotes] linking to
> remotes that lists the remotes. We may or may not want to rather have
> [branches] instead of [heads], and keep the heads action to mean *all*
> heads, local and remote, but I'm not sure about it.

Errr... that was what I meant. First patch adding feature, and adding
remotes (not separated) to 'heads' section and 'heads' view (it could
have renamed 'heads' section to 'branches' but I feel that unnecessary),
and second patch squashed which adds 'remotes' section _and_ 'remotes'
action.


>> Nice. I see the difference from git_heads is using $project . ' remotes'
>> in place of $project in git_print_header_div() (why?),
> 
> FWIW, I decided to scratch that additional ' remotes' string when
> squashing this patch.

Hmmm... I'm not sure if $project in git_print_header_div() for those
two actions is good thing to have...

-- 
Jakub Narebski
Poland
