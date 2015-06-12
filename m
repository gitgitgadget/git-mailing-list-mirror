From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-checkout.txt: Document "git checkout <pathspec>" better
Date: Fri, 12 Jun 2015 09:24:06 -0700
Message-ID: <xmqqa8w4evyx.fsf@gitster.dls.corp.google.com>
References: <5575F948.4060400@web.de>
	<xmqqioavob7n.fsf@gitster.dls.corp.google.com>
	<20150612044906.GA17424@odin.ulthar.us>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, eda@waniasset.com,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Scott Schmit <i.grok@comcast.net>
X-From: git-owner@vger.kernel.org Fri Jun 12 18:24:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3Rkc-00013r-Gi
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 18:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755640AbbFLQYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 12:24:10 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37012 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755638AbbFLQYI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 12:24:08 -0400
Received: by igbsb11 with SMTP id sb11so14321336igb.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 09:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tMfNw7rBVPfX0AJhyNX8jmkah9zd6bBbtMC9ABKCdQQ=;
        b=L0UpJ1t/VxtH/cyZDntDfu5EWP38NICzEGpQyRDinJaxLBkRL4CvT2aWnYLNqobMv4
         B0KBXaG49YizXHyDdNoxqVIRJ0BZzlbWkpBIldyUsXm8WgJp9jmW5ajh1K2XSF0vOZY5
         wpUGeCtXMli1wXKYyVXy/n0RfZRidNXMhgdEsBdqORNoeD+zoWZhEP+ucqHHCMXhEajn
         LYEcWG0E3Wc0KOOE8860ltDGcVS9H8SVRuMcqaWt6Lh5KpL/FAP7Iyv5Y5nXscZBAQmu
         RtrPmoKP84LDPkOHYG0hGyF4G/sScStSve8PQc6BqqAP+jJKKjZv74CeWhxd29tPLEcO
         pk1Q==
X-Received: by 10.50.132.33 with SMTP id or1mr5498648igb.31.1434126247969;
        Fri, 12 Jun 2015 09:24:07 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac40:153c:ed59:12ce])
        by mx.google.com with ESMTPSA id 9sm2772933iok.20.2015.06.12.09.24.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jun 2015 09:24:07 -0700 (PDT)
In-Reply-To: <20150612044906.GA17424@odin.ulthar.us> (Scott Schmit's message
	of "Fri, 12 Jun 2015 00:49:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271496>

Scott Schmit <i.grok@comcast.net> writes:

> On Wed, Jun 10, 2015 at 08:05:32AM -0700, Junio C Hamano wrote:
>
>> How about this?
>> 
>>         'git checkout' with <paths> or `--patch` is used to restore
>>         modified or deleted paths to their original contents from
>>         the index file or from a named <tree-ish> (most often a
>>         commit) without switching branches.
>
> I think these changes would improve the above:
>
> s/index file/index/
> - index file is implementation; the glossary only defines "index"

Yup, that was sloppy of me.  Thanks.

> s/or from/or replace paths with the contents from/
> - the latter case isn't always restoration, if <tree-ish> doesn't come
>   from an ancestor of HEAD (so I don't like "restore" in the summary
>   either)

Yes, that is why the original said 'checkout' in the first place.

> s/without switching/instead of switching/
> - 'without' implies it makes sense to restore/replace with switching
>   branches, but we've chosen not to.  (I then waste time trying to
>   understand that)

OK.

> s/commit/commit-ish/
> - tags are also tree-ishes, though you could argue this case is less
>   "often"

Correct.

> leaving:
>
> 'git checkout' with <paths> or `--patch` is used to restore modified or
> deleted paths to their original contents from the index or replace paths
> with the contents from a named <tree-ish> (most often a commit-ish)
> instead of switching branches.

Yeah, I like that.  I'd appreciate if somebody can submit the final
version as a patch form after waiting for a few days to hear other's
opinions.

> does a sha1 count as "named"? Maybe s/named //.

The "named" in the original "named tree-ish" does not mean "the
tree-ish has a human readable name (e.g. a tag)"; it merely means
"the user tells Git to use one tree-ish to use for this operation;
and the tree-ish was specified (by some means) by the user", i.e.
the same thing as "specified".  If you specify the tree-ish with its
object name, yes, you are naming that (after all, that is what
everything in sha1-name.c does).

s/a named <tree-ish>/the <tree-ish>/ in the improved text you
proposed above would be sufficient, I would think, as it is clear
which <tree-ish> we are talking about in the context.

Thanks.
