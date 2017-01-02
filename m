Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B43E205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 23:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756843AbdABXcR (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 18:32:17 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:55180 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756814AbdABXan (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Jan 2017 18:30:43 -0500
X-AuditID: 1207440c-e53ff700000009a1-5d-586ae2a23f99
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id FD.2A.02465.2A2EA685; Mon,  2 Jan 2017 18:30:42 -0500 (EST)
Received: from [192.168.69.190] (p5B10411C.dip0.t-ipconnect.de [91.16.65.28])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v02NUeG1023164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 2 Jan 2017 18:30:41 -0500
Subject: Re: [PATCH 13/17] refs: convert each_reflog_ent_fn to struct
 object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20170101191847.564741-1-sandals@crustytoothpaste.net>
 <20170101191847.564741-14-sandals@crustytoothpaste.net>
 <49fcccfa-df28-c01b-0e51-1451ecf8e784@alum.mit.edu>
 <20170102191256.fjqsns3rgjyehzgp@genre.crustytoothpaste.net>
Cc:     git discussion list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <d5fc2830-37c2-9274-77b7-97ecc5f9b763@alum.mit.edu>
Date:   Tue, 3 Jan 2017 00:30:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170102191256.fjqsns3rgjyehzgp@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsUixO6iqLvoUVaEwd0XChZdV7qZLH609DBb
        tM38weTA7LH85l8mj2e9exg9Pm+SC2CO4rJJSc3JLEst0rdL4Mp4tYS7YCJXxaaly5kaGC+z
        dzFyckgImEgsvNzL2sXIxSEkcJlR4s/UxWwQzhkmiV8XnrGBVAkLBEq8eL8PzBYRMJVY8n4f
        E0TRR0aJZ9POs4IkmAU8JOa//soMYrMJ6Eos6mlmArF5BewlFvT8Z+li5OBgEVCROHWYESQs
        KhAicXnOUTaIEkGJkzOfsIDYnAKeEsfvNkON1JPYcf0XlC0vsf3tHOYJjPyzkLTMQlI2C0nZ
        AkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6hnq5mSV6qSmlmxghIcqzg/HbOplDjAIcjEo8
        vA9isiKEWBPLiitzDzFKcjApifI+rQMK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuE9cA8ox5uS
        WFmVWpQPk5LmYFES51Vdou4nJJCeWJKanZpakFoEk5Xh4FCS4JV4CNQoWJSanlqRlplTgpBm
        4uAEGc4DNNwXpIa3uCAxtzgzHSJ/ilFRSpy3HiQhAJLIKM2D64WlkFeM4kCvCPN6gFTxANMP
        XPcroMFMQIO/xqWDDC5JREhJNTCKzFvM7Pnt2QoWjd1nGdZxVO53l5CpqpjOEGj0SV3yjIZ+
        1kGftnmJ8+IYrasUkp/9/ZqReznW/INpRsSz76snzoy86f3gV9ic6BtTW+vchdxkjf/6X5mh
        nsEvrPxo/iMJzWPHw8t/N2z9pTBZd4lV8de3Mf2nWO5NVLkd9uXWkmTT/JwcmWtKLMUZiYZa
        zEXFiQDu6IQn/AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/02/2017 08:12 PM, brian m. carlson wrote:
> On Mon, Jan 02, 2017 at 04:07:16PM +0100, Michael Haggerty wrote:
>> On 01/01/2017 08:18 PM, brian m. carlson wrote:
>>>  	/* old SP new SP name <email> SP time TAB msg LF */
>>>  	if (sb->len < 83 || sb->buf[sb->len - 1] != '\n' ||
>>> -	    get_sha1_hex(sb->buf, osha1) || sb->buf[40] != ' ' ||
>>> -	    get_sha1_hex(sb->buf + 41, nsha1) || sb->buf[81] != ' ' ||
>>> +	    get_oid_hex(sb->buf, &ooid) || sb->buf[40] != ' ' ||
>>> +	    get_oid_hex(sb->buf + 41, &noid) || sb->buf[81] != ' ' ||
>>
>> Some magic numbers above could be converted to use constants.
> 
> Yes, I saw that.  I opted to leave it as it is for the moment.

Totally understandable.

> I think
> my next series is going to include a small sscanf-style parser to parse
> these.  Right now, using constants here is going to leave it extremely
> difficult to read.  Something like the following for the OIDs:
> 
>   strbuf_git_scanf(sb, "%h %h ", &ooid, &noid);
> 
> and then following up parsing the remainder.

Maybe something with an interface like skip_prefix wouldn't be too
obnoxious:

    const char *p = sb.buf;
    if (oid_prefix(p, &ooid, &p) &&
        *p++ == ' ' &&
        oid_prefix(p, &noid, &p) && ...

> [...]

Michael

