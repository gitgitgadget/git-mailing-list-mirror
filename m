From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2013, #06; Fri, 25)
Date: Thu, 14 Nov 2013 20:38:01 +0100
Message-ID: <52852699.3000408@gmail.com>
References: <xmqqeh79hr3o.fsf@gitster.dls.corp.google.com>	<CACsJy8A3s4TUmUOC+i-k97GxxvBQ7mQmdoPJizfy1yS3rqLEkA@mail.gmail.com>	<xmqq61shgzvn.fsf@gitster.dls.corp.google.com>	<CAFFjANSnuS6_+uAd43AayojJyK-wj2wMxQ6DBD6JyN=A7xh2_A@mail.gmail.com>	<526EBEE8.7070807@gmail.com>	<CAFFjANRaphYdg6VM8cqJY3NmPz+gNE7S9S1jAgPPctUZio7+Tw@mail.gmail.com> <CAH7EuMHgH6Oe_SvjyutBaakRfyZGHpp_iimaAzpV09AnHTYntw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Karsten Blees <blees@dcon.de>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: =?ISO-8859-1?Q?Vicent_Mart=ED?= <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 14 20:38:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh2ju-0007fT-Fc
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 20:38:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756489Ab3KNTiD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Nov 2013 14:38:03 -0500
Received: from mail-wg0-f53.google.com ([74.125.82.53]:33334 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755637Ab3KNTiA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 14:38:00 -0500
Received: by mail-wg0-f53.google.com with SMTP id b13so2597857wgh.32
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 11:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ZjIgQgnsgQwbxvPsYyDBzzLqUNHZvKRkf26a8cwgyrE=;
        b=FYNPaJYsjcuewYyovZ1oN/sqGTK+r8qFN1lRJxk36APu9+hYp4VBPMvwceJusnipW/
         PH1PzyhgdkQdAFEduuMrIPnAcjrmqmvDNCCsjyDq5XAZrwCDK1yfd5y2qklBbasOjuyf
         OZoDY0upa0aO8HTaCNDhjKt8CekOXHkONhbI4mSR6qj4BXevNr+g2FLsyeaXte9h4ksp
         mecR/hgd+d3t5mWxj8HmMBUx2wvoLJcdPX0PoWSvKMZtKSFsv9w96ExKRmsysKRLvJw1
         MI4nO1UZ/v0JQWMC+rNWI3Aa+xaHZgxnk57wEp5Sd9jagGCbcY1XPEIG4WTZbrNKYYoy
         wshQ==
X-Received: by 10.180.19.201 with SMTP id h9mr4379531wie.36.1384457879339;
        Thu, 14 Nov 2013 11:37:59 -0800 (PST)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id e1sm1602186wij.6.2013.11.14.11.37.57
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Nov 2013 11:37:58 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <CAH7EuMHgH6Oe_SvjyutBaakRfyZGHpp_iimaAzpV09AnHTYntw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237876>

Am 29.10.2013 10:09, schrieb Karsten Blees:
> On Mon, Oct 28, 2013 at 10:04 PM, Vicent Mart=ED <tanoku@gmail.com> w=
rote:
>>
>> On Mon, Oct 28, 2013 at 8:45 PM, Karsten Blees <karsten.blees@gmail.=
com> wrote:
>>
>>> Regarding performance, khash uses open addressing, which requires m=
ore key comparisons (O(1/(1-load_factor))) than chaining (O(1+load_fact=
or)). However, any measurable differences will most likely be dwarfed b=
y IO costs in this particular use case.
>>
>> I don't think this is true. If you actually run a couple insertion a=
nd
>> lookup benchmarks comparing the two implementations, you'll find kha=
sh
>> to be around ~30% faster for most workloads (venturing a guess from
>> past experience). I am obviously not the author of khash, but I've
=2E..

Just out of curiosity, I added performance test code for khash to the t=
est in my current hashmap patch series [1]. It turns out that khash is =
by far the slowest of the bunch, especially with many collisions.

Again, I don't think that performance matters all that much (or in othe=
r words: _any_ hash table implementation will probably be fast enough c=
ompared to the rest that's going on). Its more a question of whether we=
 really need two different hash table implementations (and a queasy fee=
ling about the macro kludge in khash.h...).


Khash doesn't store the hash codes along with the entries (as both hash=
=2E[ch] and hashmap.[ch] do), so it needs to re-calculate hash codes on=
 every resize. For a fair comparison, the "khash" test uses keys with p=
re-calculated hash codes in the key structure. This should be similar t=
o a hash function that just copies 4 bytes from a sha1 key. Khash maps =
with more complex hash functions will be slower (see khstr).

The "khstr" test uses khash's predefined string map and khash's X31 has=
h function for strings (therefore no separate values for different hash=
 functions here).

The table is similar to what I posted for hashmap-v2 [2] (i.e. real tim=
e in seconds for 1,000 rounds =E1 100,000 entries). I just turned it ar=
ound a bit to make room for khash columns.

test | hash_fn | hashmap |  hash   |  khash  | khstr  |
-----+---------+---------+---------+---------+--------+
     | FNV     |   2.429 |  14.366 |  11.780 | 18.677 |
     | FNV  x2 |   2.946 |  14.558 |  10.922 |        |
 add | i       |   1.708 |   7.419 |   4.132 |        |
     | i    x2 |   1.791 |   8.565 |   4.502 |        |
     | i/10    |   1.555 |   1.805 | 344.691 |        |
     | i/10 x2 |   1.543 |   1.808 | 319.559 |        |
-----+---------+---------+---------+---------+--------+
     | FNV     |   1.822 |   3.452 |   4.922 |  8.309 |
get  | FNV  x2 |   2.298 |   3.194 |   4.473 |        |
100% | i       |   1.252 |   1.344 |   0.944 |        |
hits | i    x2 |   1.286 |   1.434 |   1.220 |        |
     | i/10    |   6.720 |   5.138 | 281.815 |        |
     | i/10 x2 |   6.297 |   5.188 | 257.021 |        |
-----+---------+---------+---------+---------+--------+
     | FNV     |   1.023 |   3.949 |   4.115 |  4.878 |
get  | FNV  x2 |   1.538 |   3.915 |   4.571 |        |
10%  | i       |   0.654 | 397.457 |  38.125 |        |
hits | i    x2 |   0.718 |   0.722 |   9.111 |        |
     | i/10    |   1.128 |  30.235 |  60.376 |        |
     | i/10 x2 |   1.260 |   1.082 |  43.354 |        |
-----+---------+---------+---------+---------+--------+

[1] https://github.com/kblees/git/commits/kb/hashmap-v5-khash
[2] http://article.gmane.org/gmane.comp.version-control.git/235290
