From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@lavabit.com>
Subject: Re: [PATCH] add a 'pre-push' hook
Date: Wed, 20 Aug 2008 06:26:36 +0900
Message-ID: <20080820062636.6117@nanako3.lavabit.com>
References: <d411cc4a0808191326s35a56c1i2e20d82e3885298@mail.gmail.com>
 <1219170876-46893-1-git-send-email-schacon@gmail.com>
 <d411cc4a0808191155g188b0f10je5fd79afb92f36ef@mail.gmail.com>
 <20080819185804.GA17943@coredump.intra.peff.net>
 <d411cc4a0808191200o39837fd0ka2530aed870e06b0@mail.gmail.com>
 <20080819190832.GC17943@coredump.intra.peff.net>
 <20080819195928.GB24212@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Jeff King" <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: "Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 23:28:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVYk9-0000Sl-KS
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 23:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbYHSV0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 17:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752680AbYHSV0x
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 17:26:53 -0400
Received: from karen.lavabit.com ([72.249.41.33]:40500 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583AbYHSV0w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 17:26:52 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 1EC85C7AF0;
	Tue, 19 Aug 2008 16:26:42 -0500 (CDT)
Received: from 8597.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id U7BS9TN6P0GF; Tue, 19 Aug 2008 16:26:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=nxM/naWxAU71vbbVsIsvbPdKB4amRQJHR7DP6zvbMWx768tWD8TDEcWHgOUvKxQojZwYh98/AcUxOgjNtgot2z5iF0kBWeQYdoA5GkOqPcgvtXbZ79RywH5udRInidl1RTtPgOe8S2GuqY4/6P1bN9YE8dWEUEkunJ+iKpUBOMY=;
  h=From:To:Cc:Date:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Quoting Scott Chacon <schacon@gmail.com>;
In-Reply-To: <d411cc4a0808191326s35a56c1i2e20d82e3885298@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92924>

Quoting Scott Chacon <schacon@gmail.com>:

> On Tue, Aug 19, 2008 at 12:59 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>> Jeff King <peff@peff.net> wrote:
>>>
>>> One other argument I have seen is that, to prevent the proliferation of
>>> hooks, the rule is not to add a hook that could just as easily be done
>>> as a sequence of commands. IOW, what's wrong with
>>>
>>>   run_my_automated_tests && git push
>>
>> Yup, I agree completely.
>>
>> Why not just setup an alias:
>>
>>        git config alias.send '! run_my_tests && git push "$@"'
>>
>> and retrain your fingers to use "git send ..."?
>
> Sorry, but couldn't this argument be made about any of the hooks run
> after manual operations?  ie: pre-commit, pre-applypatch, commit-msg,
> post-commit, post-applypatch?  I mean, couldn't you do :
>
> git config alias.docommit '! do_pre_commit && git commit ...' ?
>
> I thought the point of these kind of hooks was to make stuff like this
> automatic and easy to standardize for a project, so people working on
> a dozen git repos don't have to remember all the aliases they set up
> in each one.

This topic seems to come up every once in a while.

 http://thread.gmane.org/gmane.comp.version-control.git/70781/focus=71069
 http://thread.gmane.org/gmane.comp.version-control.git/79306/focus=79321

Somebody needs to describe the general rules in SubmittingPatches, perhaps?

I do not understand why Junio said he thinks this pre-push hook is a good idea.  This clearly is "you always would want to do before running a git command" case.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
