From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v8 2/4] cat-file: teach cat-file a '--literally' option
Date: Mon, 20 Apr 2015 14:27:44 +0530
Message-ID: <8CBC4DEB-EC50-4DD7-A687-443AA93A96A8@gmail.com>
References: <552E9816.6040502@gmail.com> <1429117174-4968-1-git-send-email-karthik.188@gmail.com> <20150419002807.GA11634@hashpling.org> <xmqq7ft7nz8l.fsf@gitster.dls.corp.google.com> <20150420074433.GA30422@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"sunshine@sunshineco.com" <sunshine@sunshineco.com>
To: Charles Bailey <charles@hashpling.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 10:58:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yk7Wm-0006ci-Ln
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 10:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338AbbDTI5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 04:57:55 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33680 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487AbbDTI5y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 04:57:54 -0400
Received: by pdbnk13 with SMTP id nk13so201474233pdb.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 01:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=GO55EmMk6nD0Tbo1gDTqEqo8nBc69h7KpubJuAn2Oc0=;
        b=ATvbMnNO6O3ZWGkqYWJZT8gP5nT+1yZsqJEXIf0QY4q3J7yZRyRYwuH604SdJNn8SQ
         3BZF9tW1t2MFJreW4RcX5gJIGRQmTpgc9BLIMYDJn4Fo7gqOjFpuZUjYwjyhmT6CXpqM
         AvP4PrL3blztaDVf19/vpNSUkqhFcnBRgSWOhO44bodjuVWmIxyz/KecvYYazHlwpJA0
         mRuyACVhMKxHxdHyf2BnpiSbNnAbpaGiLTTRaM37oNL4RIikSe5bTr2iDLrzyccBm4RY
         VgJUM1k6LH2gT5ccj6vdqGWPSS8DsUyeCD2T3zf3crRD1Aiyd7qZj6HORcBvxLktcEI8
         MgOg==
X-Received: by 10.66.120.69 with SMTP id la5mr26761036pab.66.1429520273841;
        Mon, 20 Apr 2015 01:57:53 -0700 (PDT)
Received: from [100.105.143.252] ([49.15.214.0])
        by mx.google.com with ESMTPSA id sw4sm17391953pbc.64.2015.04.20.01.57.50
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Apr 2015 01:57:52 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <20150420074433.GA30422@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267460>



On April 20, 2015 1:14:34 PM GMT+05:30, Charles Bailey <charles@hashpling.org> wrote:
>> On 20 Apr 2015, at 06:30, Junio C Hamano <gitster@pobox.com> wrote:
>> Charles Bailey <charles@hashpling.org> writes:
>> 
>>> The option isn't a true opposite of hash-object's --literally
>because
>>> that also allows the creation of known types with invalid contents
>(e.g.
>>> corrupt trees) whereas cat-file is quite happy to show the
>_contents_ of
>>> such corrupt objects even without --literally.
>> 
>> Not really.  If you create an object with corrupt type string (e.g.
>"BLOB"
>> instead of "blob"), cat-file would not be happy.
>
>Sorry, the emphasis should have been on "complete" of "complete
>opposite".  There are some types of bad objects that can be created
>only
>with hash-object --literally (malformed tag or tree), for which
>cat-file
>works with fine and there are other types (pun unintended - BLOB,
Sorry, but I didn't get you, broken objects created using hash-object --literally do not work with cat-file without the --literally option.
>wobble, etc.) for which --literally/--unchecked is required with
>cat-file.
>
>So I meant that cat-file's --literally is only a partial "opposite" or
>analogue of hash-object's.
>
>--allow-invalid-types? --force (in the sense of "suppress some possible
>errors")? It's not a big thing but I'm aware that if we can find a
>better
>name then now would be the best moment. If not, then --literally it is.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
