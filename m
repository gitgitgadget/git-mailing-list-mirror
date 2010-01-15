From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/9] Gitweb caching v5
Date: Fri, 15 Jan 2010 11:28:10 +0100
Message-ID: <201001151128.11211.jnareb@gmail.com>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net> <m37hrkdu4k.fsf@localhost.localdomain> <4B4FEF33.2040605@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "John 'Warthog9' Hawley" <warthog9@kernel.org>, git@vger.kernel.org
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Jan 15 11:28:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVjPm-0007SK-11
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 11:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208Ab0AOK2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 05:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962Ab0AOK2T
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 05:28:19 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:52361 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376Ab0AOK2S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 05:28:18 -0500
Received: by fxm25 with SMTP id 25so387747fxm.21
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 02:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=YHlTWGgkiuwvVvzjpeTXM+mxY9jqrq+UzN26annCgg0=;
        b=YEMsMRe4kgdQfNWESfBeOEj63ihA+HcYZfInyDs73wOLpSKboegzDZXunyQWoTCGKe
         WHUsh2d2Ke0ksGexbOsZN2ESGlmFvi5Yb/qdfl5+tneuLsEcKE0nhs6DCTe9gNxa9Ql8
         guVxZfvRXTrlmjXwcXWlWcc5OCTM89X4REqyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=NWI4EexXSajgvcBH6E90CAXR2dd5bysjGHuTT1fRNaOHlpBlA+Vh2TfrMCGjlc61T7
         k/NtPuCKBIuRa0ioGfJ162Nui01aCGhNBUifRzJLaig8lWz2joNHxvrP6kGR2lRmKCNR
         JDuYXLk61TLCE2Ln8fJa0omk5iNGUQEfJCmcQ=
Received: by 10.223.2.80 with SMTP id 16mr2540229fai.90.1263551296340;
        Fri, 15 Jan 2010 02:28:16 -0800 (PST)
Received: from ?192.168.1.13? (abvp131.neoplus.adsl.tpnet.pl [83.8.213.131])
        by mx.google.com with ESMTPS id c28sm2163958fka.49.2010.01.15.02.28.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 02:28:14 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4B4FEF33.2040605@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137061>

On Fri, 15 Jan 2010, J.H. wrote:
> On 01/14/2010 05:40 PM, Jakub Narebski wrote:
>> "John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

>>> it updates a
>>> number of elements in the caching engine, and this is a much cleaner
>>> break-out of the tree vs. what I am currently developing against.
>> 
>> Is caching engine part changed since v2?
> 
> Slightly, not dramatically.  Only changes were to modify the caching
> engine to deal with the change in output mechanism (I.E. my $output ->
> print {$fh})

O.K.

It is still quite large code dump...

>>> John 'Warthog9' Hawley (9):
[...]
>>>   gitweb: Add option to force version match
>> For me it needs to be disabled in gitweb test suite (t/gitweb-lib.sh),
>> if it is enabled by default.  I really like that I can test current
>> gitweb without need to recompile git.
>> 
>> Also it should have tests that it works as intended (both for matching
>> and non-matching versions) in t/t9501-gitweb-standalone-http-status.sh
> 
> I'll get t9501 cleaned up and make sure that the tests default to
> turning it off, and I'll add a test to confirm that this works.

I'll send you proposed fixup to squash, so if you want you can simply
wait for a bit.

[...] 
>>>   gitweb: cleanup error message produced by undefined $site_header
>> Shouldn't there be such protection for other such variables, like
>> $site_footer and $home_text (and a bit diferent protection against
>> undefined $projects_list)?  By the way, how did you arrived at
>> undefined $site_header: deafult build configuration leaves it empty,
>> but defined.
> 
> I would have to go back and figure it out, but it's something I hit
> years ago and added that check to keep it from spewing all over my logs.
> Could easily add it to the others mentioned.

Please remember that while for $home_text, $site_header and $site_footer
it would be enough to replace

  if (-f $file_variable) {
  	...
  }

with

  if (defined $file_variable && -f $file_variable) {
  	...
  }

for undefined $projects_list you have to fail (use die_error).


Defensive programming, here protecting against errors in gitweb config,
is a good idea IMHO.

>>>   gitweb: Convert output to using indirect file handle
>> I have alternate solution, using shorter filehandle name (just $out)
>> in
>> 
>>   git://repo.or.cz/git/jnareb-git.git gitweb/cache-kernel
>>   http://repo.or.cz/w/git/jnareb-git.git/shortlog/refs/heads/gitweb/cache-kernel
>> 
>> I would have to think a bit about separate handle for binary files;
>> I am not sure if it is really required.
> 
> For caching you have to have it.  When your outputing the data back from
> the cache you need to switch the output mode for the browser to receive
> the data properly.  Otherwise the resulting output from the caching
> engine is going to be garbage.  The caching engine explicitly stores the
> binary files separate from the rest of the response.

I think you don't.  Just read from cache file and print to browser in
binary (:raw) mode; IIUC the ':utf8' is needed only when you print from
Perl.

>>>   gitweb: File based caching layer (from git.kernel.org)
>> I am working (time permitting) in spliting this large code drop into
>> smaller commits, namely:
> 
> first up, is there a reason not to take the caching layer as it stands
> while you work on these?  I'm fine with adding test cases for what's
> there now if you want, but I guess I'm confused about explicitly wanting
> to break these into smaller commits.

It's there a reason to take this big code dump while we (me and you) are
working on it?  As I see there is no other work on gitweb now, and for the
time being you can run your fork for a bit.  Or is it about planned
deployment on git.fedora.org or something?  Anyway when there is official
release of git including gitweb output caching, it should be easy to switch
off from caching fork.
 
The caching code has also a few issues: coding style, Perl style (e.g.
not using $cache_enabled / $caching_enabled as boolean), duplicated code,
unnecessary open/close dance around stat (you can stat file which is not
closed), not using atomic write (I'm not sure how important this issue
is, especially with locking), not being able to replace cache by some
other caching module, etc.


>>  - href(..., -path_info => 0)          (for cache key)
> 
> You actually *really* want to have the full url vs. just the path_info.

Errr... it is not about full url (although I errorneously used relative
URL for human-readable cache key) vs only path_info, but about path_info
(for example http://git.public.com/test.git) and query (for example
http://git.public.com/?p=test.git) URLs which leads to exactly the same
view.

> While I accept that this means that you will end up with multiple
> copies of data being stored it helps dramatically if you have multiple
> sites pointing into the same caching space.  If you happen to have two
> distinct trees
> 
> http://git.public.com/?p=test.git;a=summary
> http://git.private.com/?p=test.git;a=summary
> 
> That respectively point to:
> 
> /group/public/git/test.git
> /group/private/git/test.git
> 
> you'll end up squashing the cache files needlessly and erroneously as
> what's in the cache file will depend on what last site was hit that
> generated the file.

So the key (the human-readable key, not it's MD5 digest) would be

  href(-replay=>1, -full_url=>1, -path_info=>0);

>>  - simple file based caching + tests
>>  - global expire time + tests
>>  - output caching in gitweb            (WIP)
>>  - adaptive expiration time            (planned)
>>  - tee output / cache write            (planned)
> 
> You sadly can't 'tee' the output as this would re-introduce the
> stampeding heard problem which is one of the reasons the caching layer
> came about in the first place.  Suppose you could give one person the
> output but make everyone else wait for the cache to finish writing out,
> or have the waiting client processes tail the file while it's generated
> but those both seem a little excessive vs. just waiting.

The "tee" is about serving [one person] the output, while cache is being
written.  It is a bit orthogonal issue to the 'stampeding herd' protection.
 
>>  - expire time variation from CHI      (planned)

This feature is meant to prevent cache miss stampedes[1]

[1] http://search.cpan.org/~jswartz/CHI-0.33/lib/CHI.pm#expires_variance

>>  - locking for single writer           (planned)

...or rather locking to avoid 'stampeding herd' problem.

BTW I don't recall if it isn't the solution you used, but if there exists
stale cache entry, the other clients can use stale version instead of
forcing to wait till the writer finishes updating cache.

>>  - server-side generating info         (planned)
>>  - AJAX-y generating info              (wishlist)
> 
> If it's helpful I can genuinely devote several more days to this to get
> these cleaned up.  Which would save you a fair amount of time in
> breaking this up.

I'm in the middle of working on gitweb caching, with the intent of arriving
at (super)set of features that are in your patch series.

See http://repo.or.cz/w/?p=git/jnareb-git.git;a=shortlog;h=refs/heads/gitweb/cache-kernel
(this branch is rebased / amended / rewritten).

-- 
Jakub Narebski
Poland
