From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH v2 07/11] gitweb: add 'remotes' action
Date: Sat, 15 Nov 2008 13:32:54 +0100
Message-ID: <cb7bb73a0811150432s2f3ae4bfkc0fc29d92accc635@mail.gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226616555-24503-7-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226616555-24503-8-git-send-email-giuseppe.bilotta@gmail.com>
	 <200811151316.32024.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 13:34:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1KM5-0004cD-N5
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 13:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755315AbYKOMc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 07:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752940AbYKOMc5
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 07:32:57 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:20095 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755315AbYKOMc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 07:32:56 -0500
Received: by ey-out-2122.google.com with SMTP id 6so719949eyi.37
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 04:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=tgwC5B54QkrsB1OFHZFOmlfg8+BOQwPaNfUCgnmbq6c=;
        b=dz4sEujaV1ho+fbb9ZX4gT/ljAlUU53v4bShYEcUsborizmAt7QjBoOu2oNFGewd7E
         UHkiYK3tNT+eBNFSIqNrk/67FZxTxFJy1zofzDCrjRk/yojgsFC2vnvujUVKvgxkjhPh
         2Bg4SMbTmp/UKFrQfUWOMYVpim67PAMagOCpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=by5uYHOVaoDcJO+7OAQS5nonEqF+H9JTcV2fdKutCu48ZYtUAOXmFh1wvp1rwNoh+H
         hAlehM/sBJKRv+4YgNcQiNv+VoitTRrTLlSL3whfgnaLaZ6YLZ4rTDBecz669ijxG58k
         BDl4R0sZPprR3CtmznWiPrt0p81Z7fIEPBHnA=
Received: by 10.210.66.1 with SMTP id o1mr2076181eba.174.1226752374552;
        Sat, 15 Nov 2008 04:32:54 -0800 (PST)
Received: by 10.210.132.16 with HTTP; Sat, 15 Nov 2008 04:32:54 -0800 (PST)
In-Reply-To: <200811151316.32024.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101066>

On Sat, Nov 15, 2008 at 1:16 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Thu, 13 Nov 2008, Giuseppe "Oblomov" Bilotta wrote:
>
>> This action is similar to the 'heads' action, but it displays
>> remote heads, grouped by remote repository.
>
> I think I would prefer would go together with the change that split
> the 'heads' ('branches') part of summary view into 'heads' and
> 'remotes', so that both section title header, and '...' continuation
> if present, lead to proper view.
>
> So either
>
>  [heads]  # or [branches]
>  master
>  to-submit
>  origin/master
>  origin/next
>  ...
>
> where both '[heads]' and (possibly) '...' link to 'heads' view showing
> _both_ local branches (refs/heads/*) and remote-tracking branches
> (refs/remotes/*), like in first patch of series (perhaps with some
> subdivision).
>
> Or
>
>  [heads]
>  master
>  to-submit
>  ...
>  [remotes]
>  origin/master
>  origin/next
>  ...
>
> where '[heads]' link to 'heads' view which shows only local branches
> (refs/heads/*), and '[remotes]' link to 'remotes' view which shows only
> remote-tracking branches.

That's funny, I just squashed this patch with the summary list split
view patch 8-) I'm going for the second option, to have [heads] link
to heads which only lists local heads, and [remotes] linking to
remotes that lists the remotes. We may or may not want to rather have
[branches] instead of [heads], and keep the heads action to mean *all*
heads, local and remote, but I'm not sure about it.

>> -     my @headslist = git_get_heads_list();
>> +     my @headslist = git_get_heads_list(undef, 'heads');
>
> Hmmm... I wonder if it would be possible to use some DWIM-mery on
> the side of git_get_heads_list (for example checking if first argument
> is a number, and assuming that nobody would be insane enough to use
> refs/15 for namespace), and just use git_get_heads_list('heads') here.
>
> But I guess that this form is good enough...

I've been wondering about this myself. Another possibility would be to
use named options instead of positional parameters, but then again it
all looks like overkill, at least for the time being.

>>       if (@headslist) {
>>               git_heads_body(\@headslist, $head);
>>       }
>>       git_footer_html();
>>  }
>>
>> +sub git_remotes {
>> +     my $head = git_get_head_hash($project);
>> +     git_header_html();
>> +     git_print_page_nav('','', $head,undef,$head);
>> +     git_print_header_div('summary', $project . ' remotes');
>> +
>> +     my @headslist = git_get_heads_list(undef, 'remotes');
>> +     if (@headslist) {
>> +             git_split_heads_body(\@headslist, $head);
>> +     }
>> +     git_footer_html();
>> +}
>
> Nice. I see the difference from git_heads is using $project . ' remotes'
> in place of $project in git_print_header_div() (why?),

FWIW, I decided to scratch that additional ' remotes' string when
squashing this patch.

-- 
Giuseppe "Oblomov" Bilotta
