From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH/RFC 0/7] Support for Ruby
Date: Mon, 23 Sep 2013 13:53:49 -0500
Message-ID: <CAMP44s2DfdqCLnp=CGf2O4tWi8LkoV=J2GTJiRORUGQjyrBnhg@mail.gmail.com>
References: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
	<20130921212904.GA235845@vauxhall.crustytoothpaste.net>
	<CAMP44s3Shdg40go-WyGV8QKwEGoXg8hvEe8tetMyxvx5Sb7evw@mail.gmail.com>
	<20130921235647.GC235845@vauxhall.crustytoothpaste.net>
	<523e81f338f1e_547c41e7c166be@nysa.mail>
	<20130922073120.GC13262@paksenarrion.iveqy.com>
	<CAMP44s0Lww+se6iA2NWSwkeuLdR9mc0ppnVBSjWu4d73YeP6oA@mail.gmail.com>
	<20130922081250.GD13262@paksenarrion.iveqy.com>
	<CAMP44s3OYjv2LsU+6FY_qESdCvJcD4zb46aJmKpruof3hYEGzQ@mail.gmail.com>
	<CACh33FpP_Afb-9eke8m282saUZEDA_ZVbUQvKc6R3EF3P1ZvTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Patrick Donnelly <batrick@batbytes.com>
X-From: git-owner@vger.kernel.org Mon Sep 23 20:53:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOBGe-0001Wk-5m
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 20:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883Ab3IWSxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 14:53:52 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:63560 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab3IWSxv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 14:53:51 -0400
Received: by mail-la0-f49.google.com with SMTP id ev20so2693029lab.8
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 11:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0WqahjwD8GXU4QVNqHEBYD0vM6AOt+3BCwWQ9kyLE8E=;
        b=aZ2Na7jwtJ8Io767LB/11uYZaLAc0G4fdbzz3rm3XhS3mZVmzoO9Of7OF5A1PMlmgu
         IKPNfnUbFDFUcf4W2hORKlYSn9v+0UfEgHc375g1hHrDpuRFyoN4yTAC9JfELrsUrYPd
         1tmDrb1ddDYLCUZPrCIFxR/2x0kyKkndC6ELj9LKlPZG/5Y8sELIYnLJCq4sjSHChbaY
         DS/hGBVChQ1by/VWedeCd8dBH/yKBAz0qJ0scIbbjWNlXF6yXvZJXRlG3sk9tLywTLfq
         jmDrkukE469EGItHfarK+ntEzDNr0ysJ/P+Zs2fcUQqR8CInLHKoMmonNNobnNczhPza
         CqsQ==
X-Received: by 10.112.57.49 with SMTP id f17mr3567702lbq.26.1379962429784;
 Mon, 23 Sep 2013 11:53:49 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Mon, 23 Sep 2013 11:53:49 -0700 (PDT)
In-Reply-To: <CACh33FpP_Afb-9eke8m282saUZEDA_ZVbUQvKc6R3EF3P1ZvTA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235232>

On Mon, Sep 23, 2013 at 1:20 PM, Patrick Donnelly <batrick@batbytes.com> wrote:
> Hello Felipe,
>
> On Sun, Sep 22, 2013 at 4:29 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Sun, Sep 22, 2013 at 3:12 AM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
>>> And see my humble test of what the speedup would be for git-submodule
>>> even with a faulty lua integration (still forking... but huge
>>> performance boost anyway):
>>> http://thread.gmane.org/gmane.comp.version-control.git/228031/focus=228051
>>
>> I don't see how that is relevant, but I'm certain the same can be done
>> with Ruby.
>>
>>> As you can see a lua integration would increase the git binary with
>>> 300kb.
>>
>> And my patch would increase it 49Kb.
>
> Unless you statically compile in Ruby (which is what the above quoted
> 300kb implied for Lua, in actually it is less than 200kb). [Also good
> luck statically compiling Python/Ruby into an executable.]

Yes, but that's not what the words said, the words said 'lua
integration' and 'ruby integration' would take that much. Either way
it doesn't matter, shared libraries exist for a reason. We don't need
to statically compile openssl do we? No? Good.

>> IMO the problem with lua is that it's too simple, it's syntax doesn't
>> resemble c, perl, python, shell, or ruby, it's just weird. Also, it's
>> much less popular, it's not as powerful, and there isn't a big
>> community involved with Git like with Ruby.
>
> *sigh*. At this point you've really cemented your purpose here as a
> language evangelist. It's unfortunate I have to reply to dismiss this
> FUD (which you complained about earlier, ironically) otherwise
> community accepts it as fact ("oh, I remember some guys saying Lua was
> a language for idiots...").

I dismissed the claim as FUD, when the conclusion was exaggerated, and
there was no evidence in sight.

When I say Ruby is a superior alternative, I provide evidence.

> Lua is by no means *simple*. Try "small" or "lightweight". Its syntax
> is engineered to be readable and amateur friendly. You've placed Ruby
> on a pedestal alongside those other major languages but its syntax
> doesn't resemble any of those.
>
>>Also, it's much less popular
>
> https://sites.google.com/site/marbux/home/where-lua-is-used
>
> The hallmark of a good embedded language is your users don't even know
> it is there.

Users don't even know in what language those projects are programmed,
that's irrelevant. If MediaWiki does indeed use Lua, it must be a tiny
fraction of it.

Lua is #25 in the tiobe index with 0.518%, Ruby is #13 with 1.382%,
right next to Perl. Ruby is 54 times used more in GitHub than Lua.
These are the numbers I have, if you have other numbers, please, share
them.

>>  it's not as powerful,
>
> This is really funny to me. Despite Lua's small size, it has lead the
> way for modern dynamic language features, such as coroutines, block
> level scoping and real closure, incremental GC, a simple and usable C
> API (*yes* this is a feature), and a register based VM [1]. It is
> consistently placed as the *fastest* dynamic language in existence
> [e.g. 2]? The LuaJIT compiler often achieves competitive or better
> performance than C [3]. What about this isn't powerful?

Talk is cheap, show me the code.

Do what I did. Add lua bindings for several C functions, replace a
script with a Lua script (like git request-pull), replace a major
builtin (like git reset), and show how this succinct example I
provided in Ruby would look like:

cb_data = 'foo'
for_each_ref() do |name, sha1, flags|
  puts '%s: %s: %s' % [cb_data, name, sha1_to_hex(sha1)]
end

Let's see how it looks.

Until you do that, I'd say you are the one that is language
evangelizing, I'm providing an actual real solution to a very
important problem.

-- 
Felipe Contreras
