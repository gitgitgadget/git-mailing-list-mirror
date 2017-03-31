Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 668A620969
	for <e@80x24.org>; Fri, 31 Mar 2017 18:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933302AbdCaSDP convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 31 Mar 2017 14:03:15 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:55028 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933205AbdCaSDO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 14:03:14 -0400
Received: from MotoRolla.fritz.box ([82.83.170.190]) by
 mrelayeu.kundenserver.de (mreue103 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0LvQBP-1cBhuI2Rtr-010cST; Fri, 31 Mar 2017 20:03:01 +0200
Date:   Fri, 31 Mar 2017 20:02:57 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqqtw69z8vz.fsf@gitster.mtv.corp.google.com>
References: <xmqqinmq65at.fsf@gitster.mtv.corp.google.com> <cover.1490967948.git.git@grubix.eu> <21cf9d6f55d17463ab6eccdd78d57cf4a1b8e9e1.1490967948.git.git@grubix.eu> <xmqqtw69z8vz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v3 3/4] name-rev: provide debug output
To:     Junio C Hamano <gitster@pobox.com>
CC:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <14D0E7F4-0DC7-42ED-8DEE-B0338ECBA80D@grubix.eu>
X-Provags-ID: V03:K0:mgrZv2/loN+d4szv/JQA5fODyXdgzOZw4PmdJLB5ycGbvTD9GJ4
 B3S55bCTp7DpHfLcGt5RSu0p0ab5YUUztc0QECTbzAJ0ZKt/+bPZzRq71lW7/e8EusEW+hr
 A3UA86vmabZ9RnHeSqS+hwKJDioBPY52NWwjMHid4wt/4eAJ1fBdgVRKv0Gjh81AXKxVzvi
 BcdzCicM8MB19jjcMRrdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IAFBTkzoJXo=:oJLlVYD3740woE3kSRDnCd
 7MfydUeJ3M9oImoTjBDNdQ6dFfQwxdupOVsDVBCQ4L1EQMw1SlmxhjGGWV62lHBQlCbbW1jd8
 nIFJznx+LbL2Bl7llzh6s3wPNdf4hgImi08eP4DKlmS+V1JXKshZrRfz8T3yTlzT1dYkS9Fp4
 ufdMWgYb0pzBhyqIva1OKU9QIbKoWFkX5DF/0eVdgW8PvKhCqIAIEhpxMzM23zOQE8An+mpjL
 PGNInrBjKWPQZtoi5beMQoVpxeF42eSVwkgaya+WxXPxnxkLz+vYeggkYnGXOW6aD2HW/QxAg
 msWMJBUFBWrzSnxZRVun/quwcFZZL3pmT22A3aS/eDWENVVXBusMMOE4/Uv9nPV1SL5lmpw2v
 /qH6VeikcC4dnEXfneS2sejwCWqdDb1Rx3O/UdZNhxrDlE3sNceAkHLSe+xl3WjBHGy+NC9Kz
 eafUZnR62IaqYJJjpLvwaCWkBYih2J/+COxqQTsZSshjbmg7QRuItXpBg7IRrtE2aeU1BvGFU
 KKMWNY2SB9C4OCcksiIf/KtuLE7WvT+a1XxAzxit3ZPNZ5ybcXyvalyhcpsMCT7u+8Eg/YD3B
 gBCt3y1sVBtr772BmxyjE/JuUNp9627NRJH//TtSBjKIsN8mqblYJUgCNpR/Pk8aWcAWetBKu
 R9jdtcp0sC6vStVljpjo94rYA17daUpuS8BDADEaT8tqulwMuMarfsc9d3+zqkpa9uF2yaMM8
 os9j6c3wnT8myX7U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31. März 2017 18:52:16 MESZ schrieb Junio C Hamano <gitster@pobox.com>:
>Michael J Gruber <git@grubix.eu> writes:
>
>> Currently, `git describe --contains --debug` does not create any
>debug
>> output because it does not pass the flag down to `git name-rev`,
>which
>> does not know that flag.
>>
>> Teach the latter that flag, so that the former can pass it down (in
>> the following commit).
>>
>> The output is patterned after that of `git describe --debug`, with
>the
>> following differences:
>>
>> describe loops over all args to describe, then over all possible
>> descriptions; name-rev does it the other way round. Therefore, we
>need
>> to amend each possible description by the arg that it is for (and we
>> leave out the "searching to describe" header).
>>
>> The date cut-off for name-rev kicks in way more often than the
>candidate
>> number cut-off of describe, so we do not clutter the output with the
>> cut-off.
>>
>> Signed-off-by: Michael J Gruber <git@grubix.eu>
>> ---
>
>>  static void name_rev(struct commit *commit,
>>  		const char *tip_name, unsigned long taggerdate,
>>  		int generation, int distance, int from_tag,
>> -		int deref)
>> +		int deref, struct name_ref_data *data)
>>  {
>>  	struct rev_name *name = (struct rev_name *)commit->util;
>>  	struct commit_list *parents;
>> @@ -75,6 +88,7 @@ static void name_rev(struct commit *commit,
>>  
>>  	if (deref) {
>>  		tip_name = xstrfmt("%s^0", tip_name);
>> +		from_tag += 1;
>
>Why this change?  I didn't see it explained in the proposed log
>message.  "deref" is true only when our immediate caller is the one
>that inspected the object at the tip and found it to be a tag object
>(i.e. not a lightweight tag or a branch).  from_tag is about "is the
>tip within refs/tags/ hierarchy?  Yes/No?" and such a caller will
>set it appropriately when calling us.  This function just passes it
>down when it recursively calls itself.  
>
>We shouldn't be mucking with that value ourselves here, should we?
>
>The only case that this change may make a difference I can think of
>is when you have a tag object pointed at from outside refs/tags
>(e.g. refs/heads/foo is a tag object); if you are trying to change
>the definition of "from_tag" from the current "Is the tip inside
>refs/tags/?" to "Is the tip either inside refs/tags/ or is it a tag
>object anywhere?", that may be a good change (I didn't think things
>through, though), but that shouldn't be hidden inside a commit that
>claims to only add support for debugging.
>
>What problem are you solving?  

Sorry, I forgot about that change and failed to mention it.

It makes no difference in the non-debug case which cares about the Boolean only. In the debug case, I want to distinguish between annotated and lightweight tags, just like describe --debug does. By adding 1 via deref and passing this down, I know that an annotated tag gets the value 2, a lightweight tag 1 and everything else 0, just like describe --tags.

>> @@ -236,7 +273,6 @@ static int name_ref(const char *path, const
>struct object_id *oid, int flags, vo
>>  	}
>>  
>>  	add_to_tip_table(oid->hash, path, can_abbreviate_output);
>> -
>>  	while (o && o->type == OBJ_TAG) {
>>  		struct tag *t = (struct tag *) o;
>>  		if (!t->tagged)
>
>This is a patch noise we can do without.
>
>Thanks.

