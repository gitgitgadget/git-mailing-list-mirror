From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v3] config: add support for http.<url>.* settings
Date: Mon, 15 Jul 2013 02:50:48 -0700
Message-ID: <CDCD6E5C-A829-43A1-94F6-93670A339A35@gmail.com>
References: <9e7edfbc83a7284615af4ca0de39c1b@f74d39fa044aa309eaea14b9f57fe79> <7voba8pu6r.fsf@alter.siamese.dyndns.org> <455666C5-7663-4361-BF34-378D3EAE2891@gmail.com> <7vsizjn390.fsf@alter.siamese.dyndns.org> <7v4nbyic57.fsf@alter.siamese.dyndns.org> <47B58075-3FDD-48E5-9047-8650F7FC5E3B@gmail.com> <7v8v18fp2s.fsf@alter.siamese.dyndns.org> <20130715051233.GC21127@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 11:51:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyfQo-0006JQ-Dy
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 11:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754719Ab3GOJuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 05:50:54 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:32934 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab3GOJux (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 05:50:53 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so11150659pbb.33
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 02:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=0IWRv04/xwhGm3gL1fQgs3YLo7NpNeTasKgw97PK/oo=;
        b=pJnU0W925Ab4Uere9EOnKfNQXc64bDp2bUgahXOBH7iZ+XTPegDY0thaSvH+gS+j1V
         rz08lhjJ/na1cBmLgwWXqzFzyHvwrnZY+lrmdDi4nHLWrDL8XvDWUl6DlWiPkmC1nVF2
         71eh9zL0HZs6qAFcQ2XWysdt3/h1mwpEoX7/IRSL0kKL7duLkNg2xxefjkLnjRrGRKbV
         RiUbaozIvh2vK6Dgvdt1y7wiSop99aLDVeSfhlWcxjHyRqg1G/cbJzVCvcmqUSJjvgRo
         +aH3lUSRiEYZxOEEgt40Nj3qcw758jkFbi3Z/kdfvd6LuKJxpqoo5V6oNt0c4pMCcvTE
         Ccgw==
X-Received: by 10.66.26.46 with SMTP id i14mr55248128pag.25.1373881852549;
        Mon, 15 Jul 2013 02:50:52 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id tr10sm28779843pbc.22.2013.07.15.02.50.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 02:50:51 -0700 (PDT)
In-Reply-To: <20130715051233.GC21127@sigill.intra.peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230448>

(I'm attempting to combine the various separate email replies into a  
single response here, please forgive me if I mangle something up.)



On Jul 14, 2013, at 22:12, Jeff King wrote:
> On Sun, Jul 14, 2013 at 09:02:19PM -0700, Junio C Hamano wrote:
>
>>> Or proceed with what's there right now (there are a few pending
>>> updates from reviewers) and then, as Junio says above, adjust it  
>>> later
>>> if needed?
>>
>> I have been assuming that "strictly textual match" will be a subset
>> of the matching semantics Aaron and Peff suggested.  That is, if we
>> include your version in the upcoming release, the user writes the
>> http.<URLpattern>.<variable> configuration so that the entries match
>> what they want them to match, the enhanced URL matcher Aaron and
>> Peff suggested will still make them match.
>>
>> Am I mistaken?  Will there be some <URLpattern> that will not match
>> with the same URL literally?
>
> I think we need to decide now, because the two schemes are not
> compatible, and switching will break setups. Yes, the matcher that  
> Aaron
> and I suggest is a strict superset (i.e., we will not stop matching
> things that used to match), which is good. But we would not be able to
> implement "longest prefix wins" overriding anymore, which would change
> the meaning of cases like:
>
>  [http "https://example.com"] foo = 1
>  [http] foo = 2
>
> (under Kyle's scheme it is "1", and under ours "2"). We can probably
> come up with some clever rules for overriding a broken-down URL that
> would stay backwards compatible. E.g., longest-prefix-match if there  
> are
> no wildcarded components, and last-one-wins if there are. But that is
> not a rule I would want readers to have to puzzle out in the
> documentation.
>
> So I think we are much better off to decide the semantics now.

Yes.  Consider these two commands:

> git config http.foo = 2
> git config http.https://example.com/.foo = 1

I am proposing that this means https://example.com has foo set to 1  
(assuming there are no other http*.foo configurations).

The other proposal probably means that, but it might not.

Given this sequence:

> git config http.foo = 2
> git config http.https://example.com/.foo = 1
>

or this sequence:

> git config http.https://example.com/.foo = 1
> git config http.foo = 2

what actually happens when using the other proposal will depend on  
whether or not the user has previously configured any other "http.*"  
setting or any other "http.https://example.com/.*" setting since doing  
so would have established such a section in the config file and it  
will affect the order the directives are processed since they will be  
added to the existing section rather than creating a new same-named  
section at the end of the file.

For this reason the order the above two "git config" commands are  
given cannot be relied upon to determine what setting http.foo will  
have when a https://example.com/ url is accessed.

Since git config does not have a "git config --placing-after-section  
section-name http.foo 2" option it seems to me that the only way to be  
sure what you would end up with using this method is to examine the  
created config file (git config -l would be sufficient although  
probably harder to read than viewing the config file itself).

For an individual .git/config file I don't expect this to be an  
issue.  However for the --global config file, I believe quite some  
time could go by between setting one http.* option and another so it  
seems quite likely to me that the user may not remember or have ever  
been aware of what order the various [http*] sections are currently in.

This is why I originally proposed longest-match-wins semantics, but  
please read on.



On Jul 14, 2013, at 22:06, Jeff King wrote:
> I admit that these are unlikely to come up in practice, but I am  
> worried
> that there is some room for mischief here. For example:
>
>  https://example.com%2ftricky.host/repo.git

This is actually an invalid URL.  Host names may not contain '%'  
characters and can only be followed by optionally ':port' and then one  
of '/', '?', or '#'.  A URL parser would actually die when it sees the  
'%' there as there's no way to match that to the URL grammar rules.   
(It wouldn't actually be taken as part of the host name even though it  
may appear to be.)

> If we canonicalize that into:
>
>  https://example.com/tricky.host/repo.git

I don't think this will be a concern since that is an invalid  
normalization.  Perhaps there is another example that is also  
concerning that needs to be addressed?


> One of the things that gets encoded are the delimiting characters.  
> So if
> I have the URL:
>
>  https://foo%3abar@example.com
>
> you would "canonicalize" it into:
>
>  https://foo:bar@example.com
>
> But those are two different URLs entirely; the first has the username
> "foo:bar", and the second has the username "foo" and the password  
> "bar".

That would be an incorrect normalization according to RFC 3986.  '@',  
'/' and ':' must be escaped in the user:password portion and decoding  
them there is verboten (prohibited).  And delimiters in general may  
not have their escaping changed during normalization.

> So I think the three options are basically:
>
>  1. No decoding, require the user to use a consistent prefix between
>     config and other uses of the URL. I.e., your current patch. The
>     downside is that it doesn't handle any variation of input.

I have previously agreed with Aaron about this and am no longer  
proposing this.

>
>  2. Full decoding into constituent parts. This handles  
> canonicalization
>     of encoding, and also allows "wildcard" components (e.g., a URL
>     with username can match the generic "https://example.com" in the
>     config). The downside is that you cannot do a "longest prefix  
> wins"
>     rule for overriding.
>
>  3. Full decoding as in (2), but then re-assemble into a canonicalized
>     encoded URL. The upside is that you get to do "longest prefix
>     wins", but you can no longer have wildcard components. I think  
> this
>     is what you are suggesting in your mail.
>
> I'm still in favor of (2), because I think the wildcard components are
> important (and while I agree that the "longest prefix wins" is  
> nicer, we
> already have "last one wins" for the rest of the config, including the
> credential URL matcher). But I certainly think (3) is better than (1).

AIUI, currently "last one wins" only applies to same-named options.   
That is, if I have these:

> [svn-remote "svn"]
> 	useSvnsyncProps = true
> [svn]
> 	useSvnsyncProps = false

When fetching using git-svn, useSvnsyncProps will be true since "svn- 
remote.svn.useSvnsyncProps" and "svn.useSvnsyncProps" are different  
property names.



I think we've agreed that any matches must match:

1) the scheme (http:,https:,...)

2) the host name

3) the port number

4) at least a prefix of the path (that does not seem to be in  
question, the question seems to be whether or not longest match wins  
or last seen when processed by git_config() wins)

In that case the only wildcard in question is the user name.  (I don't  
think anyone is proposing matching on the user password when it has  
been included directly in the URL.)



I propose that:

1) URLs be normalized before attempting any matching (RFC 3986 rules  
here)

2) Allow a config <url> without a user to match a given url with a  
user (otherwise, the user part must match exactly)

2) Longest length path match wins (to avoid users needing to be  
cognizant of the actual order sections appear in their config file)

3) If there are multiple same-path-length matches, the last one  
encountered wins except that exact user matches are preferred over  
matches where the url contains a user but the config <url> does not.



On Jul 14, 2013, at 21:02, Junio C Hamano wrote:
> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> On Jul 12, 2013, at 13:58, Aaron Schrab wrote:
>> ...
>> This should guarantee a match in the scenario Aaron proposes above  
>> and
>> still has pretty much the same easy explanation to the user.
>>
>> Shall I go ahead and add that to the next patch version?
>>
>> Or proceed with what's there right now (there are a few pending
>> updates from reviewers) and then, as Junio says above, adjust it  
>> later
>> if needed?
>
> I have been assuming that "strictly textual match" will be a subset
> of the matching semantics Aaron and Peff suggested.  That is, if we
> include your version in the upcoming release, the user writes the
> http.<URLpattern>.<variable> configuration so that the entries match
> what they want them to match, the enhanced URL matcher Aaron and
> Peff suggested will still make them match.

Yes.  Normalizing the URLs will only create more matches, it will not  
cause any current matches to stop matching.

> Am I mistaken?  Will there be some <URLpattern> that will not match
> with the same URL literally?

I believe you are correct.

> Assuming that Aaron and Peff's enhancement will not be a backward
> incompatible update, my preference is to take the posted matching
> semantics as-is (you may have some other changes that does not
> change the "strictly textual match" semantics).



So along these lines I have prepared a forthcoming [PATCH v5] that  
adds url normalization before the comparisons.  The url normalization  
is added as a separate patch in the patch series on top of the textual  
matching with a test on top of that (it also includes the "fix parsing  
of http.sslCertPasswordProtected" change as a preparatory patch).

The forthcoming patch does not include wildcard user matching, but the  
same principle applies in that adding wildcard user matching in the  
future will only create more matches without causing any current  
matches to stop matching.

I appreciate the time you reviewers have spent looking at these  
patches and sending feedback.  I would like to see this recognized in  
the patch with a suitable annotation (Reviewed-By: or Feedback-From:  
or whatever's appropriate).  I am unclear on how to make this happen  
since, as has been pointed out, I cannot actually include a 'Reviewed- 
By:' line in a new patch I send out since such a new patch has not yet  
actually been reviewed no matter the content.

Thanks for your help,
Kyle
