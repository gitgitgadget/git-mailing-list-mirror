From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v10 11/12] Documentation: add documentation for 'git interpret-trailers'
Date: Tue, 27 May 2014 10:21:03 +0200
Message-ID: <53844AEF.1080502@alum.mit.edu>
References: <534414FB.6040604@alum.mit.edu>	<20140425.230710.1024850359228182788.chriscool@tuxfamily.org>	<535E2A69.30600@alum.mit.edu> <20140525.103721.1806399553055631284.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: christian.couder@gmail.com, gitster@pobox.com, git@vger.kernel.org,
	johan@herland.net, josh@joshtriplett.org, tr@thomasrast.ch,
	dan.carpenter@oracle.com, greg@kroah.com, peff@peff.net,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	jrnieder@gmail.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue May 27 10:21:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpCde-0003ue-TJ
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 10:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbaE0IVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 04:21:19 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50502 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752208AbaE0IVL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 May 2014 04:21:11 -0400
X-AuditID: 1207440d-f79c26d000000b51-80-53844af6b369
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 77.18.02897.6FA44835; Tue, 27 May 2014 04:21:10 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1362.dip0.t-ipconnect.de [93.219.19.98])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4R8L46q028729
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 27 May 2014 04:21:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <20140525.103721.1806399553055631284.chriscool@tuxfamily.org>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsUixO6iqPvNqyXY4P4LEYtNzycyW9ye2cJs
	8frfdBaLrivdTBYNvVeYLc4tmMFoMe/uLiaL/wvyLd7eXMJo8aOlh9li97QFbBZn3jQyWhw8
	JunA67Fz1l12j0svv7N53Hpt6/H2YYDHx6e3WDye9e5h9Lh4Sdnj8cQTrB6LH3h5TLn3n9Vj
	+YNX7B6fN8kF8ERx2yQllpQFZ6bn6dslcGfcPNzOVHC3pOL//X+sDYyzYroYOTkkBEwkpm2e
	xAphi0lcuLeerYuRi0NI4DKjRNPPA4wQzjkmidtT7jKBVPEKaEt8+D8HqIqDg0VAVeLw32CQ
	MJuArsSinmYmkLCoQJDEn7OKENWCEidnPmEBsUUE9CRuzlrMDDKSWWAFk8S3S++YQRLCAjES
	s16uY4XYdZRRYsqpz4wgCU4BL4k9rb9ZQIZKCIhL9DQGgYSZBXQk3vU9YIaw5SW2v53DPIFR
	cBaSfbOQlM1CUraAkXkVo1xiTmmubm5iZk5xarJucXJiXl5qka6RXm5miV5qSukmRkgc8u5g
	/L9O5hCjAAejEg/vBN/mYCHWxLLiytxDjJIcTEqivBGeLcFCfEn5KZUZicUZ8UWlOanFhxgl
	OJiVRHg7XYByvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJ3laQoYJF
	qempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgCI4vBsYwSIoHaO8+kHbe4oLEXKAoROsp
	RkUpcV59kIQASCKjNA9uLCy5vmIUB/pSmPccSBUPMDHDdb8CGswENHhHRyPI4JJE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250157>

tl;dr: This patch series wants to introduce a permanent new Git data
format.  The current version can write trailers in formats that it is
incapable of reading, which I consider broken.  I advocate a stricter
specification of the format of trailers, at least until we get feedback
from users that they need more flexibility.

On 05/25/2014 10:37 AM, Christian Couder wrote:
> From: Michael Haggerty <mhagger@alum.mit.edu>
> [...]
>> * A way for users to add information to commits for whatever purpose
>>   they want, without having to convince upstream to built support in.
> 
> Yeah, I agree this is the main purpose of trailers.
> 
>> * A standard format for that information, so that all tools can agree
>>   how to read/write trailers without being confused by or breaking
>>   trailers that they didn't know about in advance.
> 
> Yeah, but don't you think this goal can sometimes go against the
> previous goal?
> 
> I mean, if some users for their project think that it's better, for
> example, if they use trailers like "Fix #42" instead of "Fix: 42",
> because their bug tracking system supports "Fix #42" better, we should
> let them do what suits them better, even if Git supports them not as
> well as if they used "Fix: 42".

The flexibility that comes from offering our users a more-or-less
general key/value store already accomplishes the first goal.  With that
the users *could* store their data as "Fix: 42" or "Fixes: #42" and
satisfy their functional requirements.

Giving them the option to use "Fix #42" doesn't make *any* new
functionality possible.  It is pure eye-candy.  And it would come at the
IMO high cost of making it harder for *everybody* to work with the
metadata.  It makes the specification more complicated.  It makes the
code more complicated.  It makes the configuration more complicated.  It
makes it more likely that there will be "false positives" (text in a
commit message that our code recognizes as key/value data even though it
was not meant to be).  And in my opinion it makes the k/v data itself
harder for a human to read because it is not in a uniform format.

The only justification I can think of for allowing more flexible formats
would be to "retroactively" support metadata that people already have in
their history.  Are there "famous" or "important" existing metadata
formats that are incompatible with "Key: Value"?

More to the point: do you have a concrete reason for wanting to support
alternative formats like "Fix #42", or is it based more on the feeling
that users will want it?

Remember, it would be really easy to release v1 of this feature with a
strict format, then wait and see if users clamor for more flexibility.
We can always add more flexibility later.  Whereas if v1 already
supports more flexible formats, we pretty much have to support them forever.

>> * A format that is straightforward enough that it can be machine-
>>   readable with minimum ambiguity.
> 
> Yeah, but again this could go against the main purpose of trailers
> above.

No, the users have all the flexibility they need if they can choose
their own key/value schema.  Allowing alternative formats adds very little.

I feel strongly that it would be a bad mistake to leave the
specification of trailers so loose that they cannot be machine-readable
with a good degree of confidence.  Tools that add trailers should be
composable.  The current scheme is not.  For example, suppose one tool
wants to add a "Fix #42" line and another one wants to add "Signed-off-by":

    git config trailer.fix.key "Fix #"
    git config trailer.sign.key "Signed-off-by: "
    git config trailer.sign.ifexists doNothing

    echo "subject

    Signed-off-by: Alice <alice@example.com>" |
        git interpret-trailers --trailer fix=42 |
        git interpret-trailers --trailer sign="Bob <bob@example.com>"
    --------- output ------------------------------------------
    subject

    Signed-off-by: Alice <alice@example.com>
    Fix #42

    Signed-off-by: Bob <bob@example.com>
    -----------------------------------------------------------

The result is that the trailers end up not in one block but in two
(meaning that the first block is no longer recognized as a trailer
block), and the second "Signed-off-by" line, which should have been
omitted because of ifexists=doNothing, was incorrectly added.

Or let's do something like the "commit template" example from the
documentation, but using "Fix #" instead of "Fixes: ":

    echo "***subject***

    ***message***

    Fix #
    Cc:
    Reviewed-by:
    Signed-off-by:
    " |
        sed -Ee 's/(Reviewed-by.*)/\1me/' |
        git interpret-trailers --trim-empty --trailer "git-version: foo"
    ---------- output ------------------------------------------
    ***subject***

    ***message***

    Fix #
    Cc:
    Reviewed-by: me
    Signed-off-by:

    git-version: foo
    ------------------------------------------------------------

Not only haven't the empty lines been stripped off, but a new trailer
block has been created for "git-version".

I consider this broken.

> [...]
>> For example the specification
>> might look something like:
>>
>>     A commit message can optionally end with a block of trailers.
>>     The trailers, if present, must be separated from the rest of the
>>     commit message by one or more blank lines (lines that contain only
>>     whitespace).  There must be no blank lines within the list of
>>     trailers.  It is allowed to have blank lines after the trailers.
>>
>>     Each trailer line must match the following Perl regular
>>     expression:
>>
>>         ^([A-Za-z0-9_-]+)\s*:\s*(.*[^\s])\s*$
>>
>>     The string matching the first group is called the key and the string
>>     matching the second is called the value.  Keys are considered to be
>>     case-insensitive [or should they be case-sensitive?].  The
>>     interpretation of values is left entirely up to the application.
>>     Values must not be empty.
> 
> I tried to be clearer in the v12 I just posted, and I think it should
> be enough to be very clear. We might want to tweak a little the
> specifications later, so being too strict might be counter productive.
> 
> And as other tools might already use trailers in a case-sensitive way
> and yet other tools in a case-insensitive way, I am not sure we would
> gain anything by specifying if keys or values should be interpreted in
> a case-sensitive or case-insensitive way. On the contrary we might
> upset people already using some of these tools for no good reason.

No sane tool would interpret a trailer differently depending on how the
key is capitalized.  So I think that if we ourselves treat the keys
case-insensitively but we preserve case when processing metadata, there
won't be any problems.

>>     However, in --draft and --cleanup modes, empty values *are*
>>     allowed, as are comments (lines starting with `core.commentchar`)
>>     within the trailer block.  In --draft mode such lines are passed
>>     through unchanged, and in --cleanup mode such lines are removed.
> 
> I am not sure we should use modes. I think options like
> "--trim-empty", "--allow-comments", "--allow-empty" might be clearer.

I think we want to train users to think of trailers-with-no-values as
temporary helpers that shouldn't end up in commits, just like the
"#"-commented lines in commit message templates.  Why?  Because you
can't rely on their being preserved.  As soon as your trailer goes
through a "--cleanup" (which might be there because of an unrelated
tool) it will disappear.  For the user it is a simpler mental model to
think of modes: as long as I am in draft mode, there might be comment
lines and trailer templates in my commit message, but when I commit they
will go away.  I would go so far as to say that deleting trailer lines
with no values should be a standard part of cleaning commit messages and
should maybe be an option offered by "git stripspace".

> [...]
>> So my preference would be to make the format of trailers really strict;
>> for example, only allowing colon separators as in the regexp above.
>> People who want to work with trailers using Git tools will just have to
>> conform to this format.
> 
> I don't think we should cast in stone the format for trailers, because
> of the main purpose of trailers.
> 
> The format of the commit header for example is cast in stone, but
> that's ok because it is mostly for Git internal use. Trailers are
> mostly for external use by users who already have tools expecting
> different formats.
> 
> There are already users who are not happy that they cannot easily have
> other commit headers, and we point them to trailers. If we specify
> trailers too strictly, where will we point them to?

Nobody is disagreeing that users should be allowed to choose their own
keys and values and assign their own interpretations to them.  If we let
users add their own commit headers, we certainly wouldn't let them
define a header formatted like "Fix #42", would we?

Again, the *only* justification for more flexible formats would be if
there are a lot of tools that *already* exist out there that don't
conform to "Key: value".  Are there?  New tools will certainly be
written to use whatever format we define, and in exchange they will be
able to use your awesome new tool and hopefully other upcoming tools for
dealing with trailers.

>> But if we must support flexibility in the separator characters, then I
>> think it is important that we be able to read whatever we can write.
> 
> An option like --input-separator might be enough to support this.

This would not be adequate because a single commit message might have
multiple trailers with different formats:

    Signed-off-by: me
    Fix #42

Either the input separator would have to be specified for every single
trailer (which is impractical because you can't dictate centrally how
git clients are configured) or the parsing code would have to be taught
to read any allowed format.

>> For me this means:
>>
>> * Enumerating a list of allowed separators (e.g., [:=#])
> 
> Junio suggested in a message that users might use different separators
> like '%'.

The fewer and stricter the better, to avoid false positive matches to
non-trailer text.

>> * Specifying how it is decided what separator to use when generating
>>   new trailers
> 
> This is already possible with the 'trailer.<token>.key' config
> variable.

This means that if one developer has forgotten to configure the "Fix"
trailer in one clone, then he will generate trailers that are considered
malformed by a colleague who has configured "Fix #".

>> * Specifying what appends when a trailer is read and then written again:
>>   is its separator preserved, or is the trailer converted to use the
>>   separator configured for that particular key in the config.  And if
>>   the latter, what happens if a key's separator is not configured?
> 
> Right now we only accept ':' as input separator for the messages and
> ':' and '=' for the --trailer option, and the default output separator
> is ':'. If the user specify a different separator in a key, this
> separator will be used only in the output for this key.

I consider trailers that can only be written but not read to be broken.
 My questions are to probe one possible alternate reality, namely:
"Suppose we want to allow alternative trailer formats.  What would it
take to make them readable *and* writable?"

For example:

* What if I try to add a Signed-off-by trailer to a message that already
contains "Fix #42"?  In what form should the "Fix #42" line be written
to the output

  * if I don't have the separator for "Fix" configured?
  * if I have the separator for "Fix" configured to be "="?

* What if I *do* have the separator for "Fix" set to " #", but the input
contains "Fix: 42"?  How should that line be formatted on output?  Does
the answer change if I have "token.fix.ifexist" set to "overwrite" and
run "git interpret-trailers fix=43"?

By asking these questions, I hope to hint that supporting alternative
formats increases the complexity of the specification and the
implementation to an unjustifiable extent and/or it unrealistically
relies all developers on a project having their trailer configuration
set up correctly.

> If this is not clear in the documentation, please susggest specific
> improvements.
> [...]
> I tried to be very clear in the doc in v12.

The doc only covers writing new trailers in "alternative" formats, not
reading them.

> [...]
>> Given Git's requirements for backwards compatibility, a specification
>> that we release now will have to be supported forever (because it will
>> be baked into commits and can *never* be changed), and any
>> trailer-handling tools that we release now will have to be supported for
>> years (until at least Git 3.0).
> 
> Yeah, I know that. So if we are too strict in the specification will
> be stuck for a long time.

No, that's exactly backwards!  We can easily loosen the format in the
future.  Projects don't need to output trailers in the looser format
until everybody involved is using the new Git version.

But the format can never be made *more* strict, because then the
metadata that users have added to their history will stop being readable.

>> All in all, I think that there has been a lot of discussion about the
>> interface of this one command, "git interpret-trailers", including its
>> quite complicated configuration and a command-line behavior.  And yet it
>> seems to me that not many Git developers have been very engaged in the
>> conversation, and Junio (who has) still doesn't seem satisfied with it.
>>  I (though among the too-little engaged) have the feeling that it is
>> still a ways from maturity.
> 
> My opinion is that many Git developers have been engaged and you can
> see that in the Cc.
> 
> I cannot tell if they are all very happy or not but I suppose that if
> they were very unhappy they would tell it.
> [...]

It was unfair of me to try to characterize the opinions of other
developers.  On the other hand, even though many people have commented
on this proposal over its long lifetime, I didn't get the feeling that
it has won a consensus of +1s in its current form.

I'd love to hear the opinion of others because maybe I'm totally out in
left field.

And I want to reiterate that the reason I'm so emphatic about this
proposal is because I think it will be such a great new feature.  I just
think that some tweaks would make it a more solid foundation for
building even more functionality onto.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
