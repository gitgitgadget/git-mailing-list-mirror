From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] protocol upload-pack-v2
Date: Fri, 6 Mar 2015 20:28:17 -0800
Message-ID: <CAGZ79kZBYFSwR6E86BF6Dt7xdh0zs07tkGnQAKfEJpSduTK-aw@mail.gmail.com>
References: <20150302092136.GA30278@lanh>
	<1425685087-21633-1-git-send-email-sbeller@google.com>
	<xmqqr3t1vefz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 05:28:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU6Ln-0002Dv-2O
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 05:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078AbbCGE2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 23:28:20 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:42921 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbbCGE2T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 23:28:19 -0500
Received: by igkb16 with SMTP id b16so8979313igk.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 20:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=a6QOkwLTNs6E/X15meOfarsdC9857qtRUugDH8Jqbcw=;
        b=PNX4dSyF04KzA49fxAXd31gvleJdxKmc6KR1uqTnYPQTntk2ix+NXYxnxu3bGnaD46
         b7liKwowAkaKhHg/paw2n39uu6WMCzud8KwkXYsHOUL7hQ4BJ2Nl/Alvvvbt8BCQKsH0
         foDFHFew2owrkzrMj6c9Bkq1Wlz8/KXBztYnIUcVW16aluSJtqAr16WNxLGa0oKIv0aF
         zRq0ctcwUfboAQ1zPpFHsn0JvGmX3c9R+zd1I7qgbhgC0e+I3xmZggBmJ8yNP+pYG58x
         ndeJXWunhNafzIUFc2xyiAsVlBQIqmg6XPssETO61D49bIcU6wVhpFJrohC2YKS1TJ0j
         hmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=a6QOkwLTNs6E/X15meOfarsdC9857qtRUugDH8Jqbcw=;
        b=ahj1e6IXf9zQLIMojicns3H3G0VP5MIj9Cevg8wTP/aB5a2rqXQIaqjrjdA7ielRO+
         C2s935rIDihNMXeGtcrkKaWVTYQXGFxe7KdT+SA13CeeWpFuqcGjz6FiPIFG4AUBaTnq
         AdJdc0iuhwTvCh5ygKXJjb3msbjvEwQbcqDGF8z9luOBJBIGgDkUfo3MYWM5bKKAClaH
         cPELbtGCzTPPsRMYTX7Iz5J9GEy+rjGj0RRHmSWdErrBKLPJhw55j2xII2PfbWF5rTnM
         c9JUluB1q8SWx4MsOWDrfa4CGBA3yMfCcT5iRmfSR9MsLXEdYI/XXrEFg65053qbFLCX
         1cxA==
X-Gm-Message-State: ALoCoQlqsXtrPRp4VuC8UEb6UXykd3h4oakR6tFs6WVK3fmfgDEFGtFIYtwRXVjwTSRe1vpy27CV
X-Received: by 10.42.92.16 with SMTP id r16mr14086923icm.95.1425702498068;
 Fri, 06 Mar 2015 20:28:18 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Fri, 6 Mar 2015 20:28:17 -0800 (PST)
In-Reply-To: <xmqqr3t1vefz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264988>

On Fri, Mar 6, 2015 at 4:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> @@ -67,7 +74,6 @@ gracefully with an error message.
>>    error-line     =  PKT-LINE("ERR" SP explanation-text)
>>  ----
>>
>> -
>>  SSH Transport
>
> Noise?
>
>> @@ -124,9 +130,56 @@ has, the first can 'fetch' from the second.  This operation determines
>>  what data the server has that the client does not then streams that
>>  data down to the client in packfile format.
>>
>> +Capability discovery (v2)
>> +-------------------------
>>
>> +In version 1, capability discovery is part of reference discovery and
>> +covered in reference discovery section.
>> +
>> +In version 2, when the client initially connects, the server
>> +immediately sends its capabilities to the client. Then the client must
>> +send the list of server capabilities it wants to use to the server.
>> +
>> +   S: 00XXcapabilities 4\n
>> +   S: 00XXcap:lang\n
>> +   S: 00XXcap:thin-pack\n
>> +   S: 00XXcap:ofs-delta\n
>> +   S: 00XXagent:agent=git/2:3.4.5+custom-739-gb850f98\n
>> +
>> +   C: 00XXcapabilities 3
>> +   C: 00XXcap:thin-pack\n
>> +   C: 00XXcap:ofs-delta\n
>> +   C: 00XXcap:lang=en\n
>> +   C: 00XXagent:agent=git/custom_string\n
>
> I do not see a good reason why we want "I am sending N caps"
> upfront, instead of "this, that, and here is the end of the group".

I thought about having an end marker, so something like
capabilities start
thin-pack
lang
ofs-delta
capabilities done

(Each line a pkt-line)

Though all decisions I thought through I tried to put more weight on
future expandability. Now that I think about it again, it makes no
difference, whether to use a counter or an end marker.

> If you expect the recipient to benefit by being able to pre-allocate
> N slots, then that might make sense, but otherwise, I'd rather see
> us stick to a (weaker) flush that says "group ends here".

I think it's not about pre allocating but counting down. Then you know
at the beginning how much to expect which might become relevant if
that section grows large again. ("The server really wants to send 1500
capability lines? Nope I'll just disconnect because I am on mobile!")

Implementation wise an end marker is easier though (you don't need
to count down, so it feels more stateless to me).

>
> Besides, I do not know how you counted 4 on the S: side and 3 on
> the C: side in the above example and missing LF after 3 ;-).
>

Sorry about that, I added one answer late and forgot to increment the 3.

>> +----
>> +  cap              =  PKT-LINE("capabilities" SP size LF list)
>
> Isn't a cap packet terminated by LF without any "list" following it?
> The notation PKT-LINE(<blah>) is "wrap <blah> in a single packet",
> and I do not think you meant to send the capability line and a series
> of cap:foo entries in a single packet.

Yeah I meant to use one packet per line
So after considering your input, you'd want to have
PKT-LINE("capabilities start")
PKT-LINE("no-prefix-for-capabilities")
PKT-LINE("ofs-delta")
PKT-LINE("agent-as-capability-2.6")
PKT-LINE("capabilities end")

And additionally to that a PKT-LINE should have the ability to grow larger than
0xffff, which would be encoded with 0xffff being an escape character
indicating the
length is encoded somehow different. (Maybe take the next 8 bytes
instead of just 4).


>
>> +  size             =  *DIGIT
>> +  capability-list  =  *(capability) [agent LF]
>> +  capability       =  "cap:" keyvaluepair LF
>> +  agent            =  keyvaluepair LF
>
> I do not see a reason to make 'agent' as part of capability.  That
> was an implementation detail of v1 but v2 does not have an
> obligation to consider agent announcement as capability.

So I think we don't want to drop the agent announcement as it may
reveal useful information ("How many outdated clients connect to our
$HOSTING_SITE?", "I need to debug failures which happen only rarely,
Oh! it can be narrowed down to clients with agent xyz.")

So then we need to decide where to put the agent. And as it is only small
but useful (meta?)-information I'd rather put it at the beginning of the
data exchange, so in case the other side seems to be missbehaving,
it is easier to debug in the hope the agent transmission was still
successful.

>
> server-announcement = PKT-LINE("capabilities" ...) capability-list [agent-announcement]
> capability-list = as you have it w/o "[agent LF]"
> agent-announcement = PKT-LINE("agent=" agent-token LF)
>
> or something, perhaps?

This looks like me as if all capabilities are in one PKT-LINE, which
you seemed to oppose?

>
>> +The client MUST ignore any data before the pkt-line starting with "capabilities"
>> +for future easy of extension.
>
> s/easy/ease/; but I am not sure if this makes sense.  Without
> knowing the extended preamble, you cannot even tell if a packet line
> that happens to start with "capabilities" is a proper beginning of
> 0-th iteration of v2 protocol, or an embedded data in the preamble,
> no?

I rather thought about the case where the implementation would
just close the connection on sight of unknown preamble.
If we want to extend the protocol again and the string
"capabilites" should be part before the actual capabilities start,
we will think about escaping it in the future as then we can still
talk to clients as of this design.

In case we'd close the connection we would have a similar problem as
of now, it cannot be really extended.

>
>> +Reference Discovery (v2)
>> +------------------------
>> +
>> +In version 2, reference discovery is initiated by the client with
>> +"want-refs" line. The client may skip reference discovery phase
>> +entirely by not sending "want-refs" (e.g. the client has another way
>> +to retrieve ref list).
>> +
>> +----
>> +  want-refs  =  PKT-LINE("want-refs" SP mode *argument)
>> +  mode       =  "all"
>> +  argument   =  SP arg
>> +  arg        =  1*(LC_ALPHA / DIGIT / "-" / "_" / "=")
>> +----
>> +
>> +Mode "all" sends all visible refs to the client like in version 1. No
>> +arguments are accepted in this mode. More modes may be available based
>> +on capabilities.
>
> I tend to agree with Duy that the protocol must anticipate that args
> can become longer.

ok, so PKT-LINE needs to be able to deal with larger lines, I'll add that.

>
>> +----
>> +  advertised-refs  =  (no-refs / list-of-refs)
>> +                   *shallow
>> +                   flush-pkt
>
> I am not sure if defining "shallow" as part of "refs advertisement"
> is a good idea.  The latter lives in the same place in the v1
> protocol merely because that was how it was later bolted onto the
> protocol.  But this concern can easily be allayed by retitling
> "advertised-refs" to something else.

I don't quite understand this. What are your concerns about shallow here?

Thanks on the feedback!
Stefan
