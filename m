From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 2/3] config: add 'type' to config_source struct that identifies config type
Date: Sun, 14 Feb 2016 13:26:27 +0100
Message-ID: <A74A1FE2-7C03-448F-8147-BBF276322E62@gmail.com>
References: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com> <1455373456-64691-3-git-send-email-larsxschneider@gmail.com> <20160213172435.GG30144@sigill.intra.peff.net> <xmqqio1ss4on.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	sschuberth@gmail.com, ramsay@ramsayjones.plus.com,
	sunshine@sunshineco.com, hvoigt@hvoigt.net, sbeller@google.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 13:26:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUvl3-0003lj-Dv
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 13:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbcBNM0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2016 07:26:30 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33090 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbcBNM03 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Feb 2016 07:26:29 -0500
Received: by mail-wm0-f67.google.com with SMTP id c200so11145919wme.0
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 04:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UhFhRYABX15jnoT1QlPt6wzNs+uz3/1rduFaGN0GQ3g=;
        b=JAFSD8ETZUpnWGHDVrBZ+UKX8glyn2jAThR0AI4YJyYcTchEnbOz6AnPHz6nLptqSU
         C+YZxyT1i0iluegozrFVBLdUAyyPcOweZMzWX+5CATwy4VRq+zVn/Lu2cIbeNN/TUTo0
         1EAQyA1Fiot3OJ5hx4tlBYWHsVaKivsseRGmzI8omXPSdgAgwqNt4U3tnrZvl9GAGHWj
         qXBSsa1O1A7aK64CU3JZ0H557TSD2vzMDYzAY4djApIde3MJSsg449e9/ARhzm3e/Bwd
         iOkm9iyMRMaonHXP2Gili3z3W9d30L3gGqY30MwdzIOuwQtnoJH9zxArXpWFoRWevPgQ
         lszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=UhFhRYABX15jnoT1QlPt6wzNs+uz3/1rduFaGN0GQ3g=;
        b=W5MvZbdwoi2IZotpLoLbefyE5I10SDku7FtjTlNxPvxRXMXn5jahfTdCgGZvWwf0w8
         DjL940oJA+qdTG2MXc9TfPl5C8l4qEvUegJcLqnm/GL3iY54c1eeei6qj9bcKg3rMbEI
         SSB2sCL80UCgpmFNhJRHDuFGyOHPLFTS/CHKxxpoqPyXSM9sORGeFxmyQDFq6D4IPD1g
         zn2Ev/mCvF4L0GF4IfquvBXdwmX0XtbzYUfQvCILpVKgbVG/cTasr99cNAy4JO5N2aTL
         DVfmUpFb1ZHc4WvibYa/7/dNyRY8Rt+FKfsy93xmJbJWEb2bgZT3HLRePMo0GgFm/2ON
         Nr9Q==
X-Gm-Message-State: AG10YOR66D9MKG0uEfqxxO61wA1pr19tUdcd2Pp/Z3JNvleV7kLEEt3TTr1O+PX8nG1L0w==
X-Received: by 10.28.145.9 with SMTP id t9mr7724094wmd.54.1455452788386;
        Sun, 14 Feb 2016 04:26:28 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB4789.dip0.t-ipconnect.de. [93.219.71.137])
        by smtp.gmail.com with ESMTPSA id lh1sm20360009wjb.20.2016.02.14.04.26.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Feb 2016 04:26:27 -0800 (PST)
In-Reply-To: <xmqqio1ss4on.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286152>


On 13 Feb 2016, at 22:04, Junio C Hamano <gitster@pobox.com> wrote:

> Jeff King <peff@peff.net> writes:
> 
>>> @@ -1104,6 +1106,7 @@ int git_config_from_buf(config_fn_t fn, const char *name, const char *buf,
>>> 	top.u.buf.buf = buf;
>>> 	top.u.buf.len = len;
>>> 	top.u.buf.pos = 0;
>>> +	top.type = "blob";
>>> 	top.name = name;
>>> 	top.path = NULL;
>>> 	top.die_on_error = 0;
>> 
>> This function is about reading config from a memory buffer. The only reason
>> we do so _now_ is when reading from a blob, but I think it is laying a
>> trap for somebody who wants to reuse the function later.
>> 
>> Should git_config_from_buf() take a "type" parameter, and
>> git_config_from_blob_sha1() pass in "blob"?
> 
> I think that is sensible.  I think s/from_buf/from_mem/ may also be
> sensible (it would match the naming used in the index_{fd,mem,...}
> functions in he hashing code).
OK, I will change that, too!


> 
>>> static int git_config_from_stdin(config_fn_t fn, void *data)
>>> {
>>> -	return do_config_from_file(fn, "<stdin>", NULL, stdin, data);
>>> +	return do_config_from_file(fn, NULL, NULL, stdin, data);
>>> }
>> 
>> Likewise here, we make assumptions in do_config_from_file() about what
>> the NULL path means. I think this is less likely to be a problem than
>> the other case, but it seems like it would be cleaner for "file" or
>> "stdin" to come from the caller, which knows for sure what we are doing.
> 
> Makes sense.
> 
>> Similarly, I think git_config_from_stdin() can simply pass in an empty
>> name rather than NULL to avoid do_config_from_file() having to fix it
>> up.
> 
> This too.
> 
>>> +test_expect_success 'invalid stdin config' '
>>> +	echo "fatal: bad config line 1 in stdin " >expect &&
>>> +	echo "[broken" | test_must_fail git config --list --file - >output 2>&1 &&
>>> +	test_cmp expect output
>>> +'
>> 
>> The original would have been "bad config file line 1 in <stdin>"; I
>> think this is an improvement to drop the "file" here.
>> 
>> -Peff

Thanks,
Lars
