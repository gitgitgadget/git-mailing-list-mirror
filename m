Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 363641FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 18:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753389AbdBJSok (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 13:44:40 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:37803 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbdBJSoi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 13:44:38 -0500
Received: by mail-it0-f50.google.com with SMTP id r185so39248963ita.0
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 10:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=gdZjusLT9En3EJEgmLb6q1Qwf6KQeIY5qi+ftSzixnU=;
        b=W1k6TJmXXHlQDWRpoFaBA8L26DP/bY3Rjy+Fe5JCuouEOnhv3VcUKFWfp6MdhIxbqB
         oM9fSYqFxgzd0Y4qNeWNU4sVaHz/zp4Y8ckEgM6Zqgo/O1nwgqzBsVW0vQV9flvZqev4
         TNj9Y7qxPE4ICdkVl3Q5ZKCl9cCiPaLRF5l+ecL85NezWnt92XkjZY6N8Djodkvi8xu1
         +aZqW94RPgLTJz3zjpS5vzdZptKoMHY7ELuw1Dzms1kmZ2QTKLysPRklHwZ7+VtNTORq
         IY6kj7WAgZJkDRksVFku4PZP8wGR740GQlsVzpBfhFFulN0XFLZonk/PD2bzPjSfQqRk
         gdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=gdZjusLT9En3EJEgmLb6q1Qwf6KQeIY5qi+ftSzixnU=;
        b=Zb4vKaknC5KRUeUHa3o5fi7AxOuVFn05W/E7gIuyQnGOEkWQ1kpIO6juNSAvs1SeL+
         0pLBUj9qBiEn2gjgz4sD6CVyoAyeO6GgpEnZQZlD7bSGOhlr54JNi3Ey+hqJqIDvPVyM
         Kxvipl8sXZKlOjAO331qCBMj+86z0ZOKcmD62uyvYYpWz38J+A++JUETanyhQ+Evkdgr
         auiclLNatZr9eiHHaOwGFhkKqe18bYU5x6H3VET5ENiYY0N9kSUeofDcEa6l7YaGwnBD
         0kOPwGgVQBY/ZqMeMhbI1CkJoEDIeAAvrXOhsSXSAyRFS5rqYg1UXTXk8Nsf2ea9mGKk
         uGgQ==
X-Gm-Message-State: AIkVDXJcCnr8DmwkkNnMbkDSEBSvYVQogDi6CajJOiawiyuu4A88StOIUxgxFXzWzcGzlLagnLUmZ9m32DlWOjV4
X-Received: by 10.36.65.4 with SMTP id x4mr29070302ita.69.1486752272988; Fri,
 10 Feb 2017 10:44:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Fri, 10 Feb 2017 10:44:32 -0800 (PST)
In-Reply-To: <CAFzf2XzLNOKbNbkCfzpVJtN-ROW8m8WVBsWM-z7Bxdnv55b45Q@mail.gmail.com>
References: <xmqqpoiswo0l.fsf@gitster.mtv.corp.google.com> <20170208220400.17069-1-sbeller@google.com>
 <CAFzf2XzLNOKbNbkCfzpVJtN-ROW8m8WVBsWM-z7Bxdnv55b45Q@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 10 Feb 2017 10:44:32 -0800
Message-ID: <CAGZ79katkdGb4jWHb4LX21RnG3D72Oc6V_AAu8GL+7sH0fA8pw@mail.gmail.com>
Subject: Re: [PATCHv2] push options: pass push options to the transport helper
To:     Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 9, 2017 at 5:56 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Private reply because using HTML mail on phone:

So I presume putting it back on the list is fine.

> Does this need to be a remote helper capability?

No, as all other capabilities of the git-protocol are mapped 1:1 to
the transport helper protocol for support, e.g. each transport helper
has to handle this on its own, c.f. remote-curl.c:set_option
(line 39 ff and 1065),

> What happens with remote
> helpers that don't understand the option?

The helper ought to print "unsupported"
(remote-curl.c:1065 for the http helper) and then the transport helper
will take care of it (transport-helper.c: 265 and e.g. 820)

>
> How do remote helpers communicate whether the server has said it accepts
> push options?

I guess the remote helper would communicate it the same way as communicating
if the push succeeded? (i.e. reject non fast forward.)

>
> On Wed, Feb 8, 2017, 14:04 Stefan Beller <sbeller@google.com> wrote:
>>
>> When using non-builtin protocols relying on a transport helper
>> (such as http), push options are not propagated to the helper.
>>
>> The user could ask for push options and a push would seemingly succeed,
>> but the push options would never be transported to the server,
>> misleading the users expectation.
>>
>> Fix this by propagating the push options to the transport helper.
>>
>> This is only addressing the first issue of
>>    (1) the helper protocol does not propagate push-option
>>    (2) the http helper is not prepared to handle push-option
>>
>> Once we fix (2), the http transport helper can make use of push options
>> as well, but that happens as a follow up. (1) is a bug fix, whereas (2)
>> is a feature, which is why we only do (1) here.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  Documentation/gitremote-helpers.txt |  4 ++++
>>  t/t5545-push-options.sh             | 15 +++++++++++++++
>>  transport-helper.c                  |  7 +++++++
>>  3 files changed, 26 insertions(+)
>>
>> diff --git a/Documentation/gitremote-helpers.txt
>> b/Documentation/gitremote-helpers.txt
>> index 9e8681f9e1..23474b1eab 100644
>> --- a/Documentation/gitremote-helpers.txt
>> +++ b/Documentation/gitremote-helpers.txt
>> @@ -462,6 +462,10 @@ set by Git if the remote helper has the 'option'
>> capability.
>>  'option pushcert {'true'|'false'}::
>>         GPG sign pushes.
>>
>> +'option push-option <string>::
>> +       Transmit <string> as a push option. As the a push option
>> +       must not contain LF or NUL characters, the string is not encoded.
>> +
>>  SEE ALSO
>>  --------
>>  linkgit:git-remote[1]
>> diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
>> index ea813b9383..9a57a7d8f2 100755
>> --- a/t/t5545-push-options.sh
>> +++ b/t/t5545-push-options.sh
>> @@ -3,6 +3,8 @@
>>  test_description='pushing to a repository using push options'
>>
>>  . ./test-lib.sh
>> +. "$TEST_DIRECTORY"/lib-httpd.sh
>> +start_httpd
>>
>>  mk_repo_pair () {
>>         rm -rf workbench upstream &&
>> @@ -100,4 +102,17 @@ test_expect_success 'two push options work' '
>>         test_cmp expect upstream/.git/hooks/post-receive.push_options
>>  '
>>
>> +test_expect_success 'push option denied properly by http remote helper'
>> '\
>> +       mk_repo_pair &&
>> +       git -C upstream config receive.advertisePushOptions false &&
>> +       git -C upstream config http.receivepack true &&
>> +       cp -R upstream/.git "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git &&
>> +       git clone "$HTTPD_URL"/smart/upstream test_http_clone &&
>> +       test_commit -C test_http_clone one &&
>> +       test_must_fail git -C test_http_clone push --push-option=asdf
>> origin master &&
>> +       git -C test_http_clone push origin master
>> +'
>> +
>> +stop_httpd
>> +
>>  test_done
>> diff --git a/transport-helper.c b/transport-helper.c
>> index 91aed35ebb..1258d6aedd 100644
>> --- a/transport-helper.c
>> +++ b/transport-helper.c
>> @@ -826,6 +826,13 @@ static void set_common_push_options(struct transport
>> *transport,
>>                 if (set_helper_option(transport, TRANS_OPT_PUSH_CERT,
>> "if-asked") != 0)
>>                         die("helper %s does not support
>> --signed=if-asked", name);
>>         }
>> +
>> +       if (flags & TRANSPORT_PUSH_OPTIONS) {
>> +               struct string_list_item *item;
>> +               for_each_string_list_item(item, transport->push_options)
>> +                       if (set_helper_option(transport, "push-option",
>> item->string) != 0)
>> +                               die("helper %s does not support
>> 'push-option'", name);
>> +       }
>>  }
>>
>>  static int push_refs_with_push(struct transport *transport,
>> --
>> 2.12.0.rc0.1.g018cb5e6f4
>>
>
