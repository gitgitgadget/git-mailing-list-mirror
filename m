Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6438D1FEB3
	for <e@80x24.org>; Sat,  7 Jan 2017 01:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757890AbdAGBxd (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 20:53:33 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:33762 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbdAGBxb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 20:53:31 -0500
Received: by mail-qt0-f172.google.com with SMTP id v23so94324139qtb.0
        for <git@vger.kernel.org>; Fri, 06 Jan 2017 17:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=wwa9D7fDV6I3HUk2dlvb6XlvaT+Emkvr3e9Xh9hAeVc=;
        b=IYNJb5lSCeXWJXrgrZpKojxxIeHgPVRd+3ZrVrKupDVG/OEMXzvz+P+AfAw9SeVuUB
         J+ciZVCnge4pDx7Vcbt2fvg+sKZNjtFpVqN6GZW7SBcs/fjRjzjrgVN+ir5mKmKb80MO
         D3jWHIZKG+i2YRzmaxV9o6eU0Q4CjHaPfpGCditPjKM28KFJEGNnwLwzy2ianfuOv9Pj
         Yyc8datIbmrOeipQfIZisT8hIs3osNssxYTUYYz0kW9t3gVvjpaiiJgM8hcFU1GWlbwS
         lj4tLsrm6dzVJwYq4GGYMhpn99DeT3OBVzMxR2zsH1mt3UPMeso3QVhgpkOmkCrwN2uo
         c82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=wwa9D7fDV6I3HUk2dlvb6XlvaT+Emkvr3e9Xh9hAeVc=;
        b=eM5SFfCKt9N5ep0RZsmDHl1RmMd3IqM9PtCUnGR/YCwGeT+dsEj1IqqXi6mp4L3Qs7
         jJo707+uqCVMh9M7eCbRosAb+XUI6tuNACJKTwjUQPq56VFep2mLuH8m/IrfhpGcacRK
         g54ESqh84N97mq9wDrB0RopULiI59RA7U5xneQxx8oWunu04pxx82ekEJ4eJxDST7+dG
         e8ZSEKNCW4iXZ0Du0le8H2/mbsAcP1+SQh8Y/hF9GlOTXdDbScfm462GUhn5XwwokW3c
         H0P3RdDwBxakw1arnzCQDwJGHkkckhOqxyvbvnJcKRFa3TawszD/nS2Vq+nH4AZS+RyI
         8jXw==
X-Gm-Message-State: AIkVDXJo1oCtXN6gfk8pnJsgnbgfjbsKiS9jaS/MHdMWx/Eb3J1HBYqze2VXC76l2HaUVfjc
X-Received: by 10.200.39.230 with SMTP id x35mr72806742qtx.259.1483754010602;
        Fri, 06 Jan 2017 17:53:30 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([2620:0:1004:2:11b6:6b62:9863:9910])
        by smtp.gmail.com with ESMTPSA id a69sm785809qkj.38.2017.01.06.17.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jan 2017 17:53:29 -0800 (PST)
Subject: Re: [PATCH v2 2/4] t7610: make tests more independent and debuggable
To:     Stefan Beller <sbeller@google.com>
References: <20170104005042.51530-1-hansenr@google.com>
 <20170106010945.79382-1-hansenr@google.com>
 <20170106010945.79382-3-hansenr@google.com>
 <CAGZ79kbRee+3MbAHCSFB0QqGMMF5bcZMiEHV-coRh87vFfq0Ag@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Simon Ruderich <simon@ruderich.org>
From:   Richard Hansen <hansenr@google.com>
Message-ID: <f5739254-c0c9-8791-03f3-1bf4f7eb2acf@google.com>
Date:   Fri, 6 Jan 2017 20:53:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbRee+3MbAHCSFB0QqGMMF5bcZMiEHV-coRh87vFfq0Ag@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="001a11402d82c251190545776641"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a11402d82c251190545776641
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2017-01-05 20:31, Stefan Beller wrote:
> On Thu, Jan 5, 2017 at 5:09 PM, Richard Hansen <hansenr@google.com> wrote:
>> Reduce how much a test can interfere other tests:
>
> A bullet point list as an unordered list often indicates that you're
> doing multiple
> things at once, possibly unrelated, so they could go into different patches. ;)

OK, I'll split it up.

>
> While telling you to make even more commits: you may also want to make
> a patch with an entry to the .mailmap file (assuming you're the same
> Richard Hansen that contributed from rhansen@bbn.com);
> Welcome to Google!

Good idea, thanks!

>
>>
>>   * Move setup code that multiple tests depend on to the 'setup' test
>>     case.
>>   * Run 'git reset --hard' after every test (pass or fail) to clean up
>>     in case the test fails and leaves the repository in a strange
>>     state.
>>   * If the repository must be in a particular state (beyond what is
>>     already done by the 'setup' test case) before the test can run,
>>     make the necessary repository changes in the test script even if
>>     it means duplicating some lines of code from the previous test
>>     case.
>>   * Never assume that a particular commit is checked out.
>>   * Always work on a test-specific branch when the test might create a
>>     commit.  This is not always necessary for correctness, but it
>>     improves debuggability by ensuring a commit created by test #N
>>     shows up on the testN branch, not the branch for test #N-1.
>
>
>
>
>> @@ -112,6 +146,7 @@ test_expect_success 'custom mergetool' '
>>  '
>>
>>  test_expect_success 'mergetool crlf' '
>> +       test_when_finished "git reset --hard" &&
>>         test_config core.autocrlf true &&
>>         git checkout -b test$test_count branch1 &&
>>         test_must_fail git merge master >/dev/null 2>&1 &&
>> @@ -129,11 +164,11 @@ test_expect_success 'mergetool crlf' '
>>         git submodule update -N &&
>>         test "$(cat submod/bar)" = "master submodule" &&
>>         git commit -m "branch1 resolved with mergetool - autocrlf" &&
>
>> -       test_config core.autocrlf false &&
>> -       git reset --hard
>> +       test_config core.autocrlf false
>>  '
>
> This is the nit that led me to writing this email in the first place:
> test_config is a function that sets a configuration for a single test only,
> so it makes no sense as the last statement of a test. (In its implementation
> it un-configures with test_when_finished)
>
> So I think we do not want to add it back, but rather remove this
> test_config statement.

OK, will do.

>
> But to do this we need to actually be careful with the order of the newly
> added test_when_finished "git reset --hard" and  test_config core.autocrlf true,
> which uses test_when_finished internally.

Ah, yes.  Tricky.  I'll add a comment.

>
> The order seems correct to me, as the reset would be executed after the
> "test_config core.autocrlf true" is un-configured.

Agreed; test_when_finished is LIFO (though the order is not documented).

-Richard

--001a11402d82c251190545776641
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS6QYJKoZIhvcNAQcCoIIS2jCCEtYCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBPMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
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
BgEFBQcwAoY0aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NodnNtaW1lY2Ex
LmNydDAdBgNVHQ4EFgQUbPFPDSp3rGDbNu3Pb8jJO+QTw0AwHwYDVR0jBBgwFoAUyzgSsMeZwHiS
jLMhleb0JmLA4D8wTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wOwYDVR0fBDQwMjAwoC6gLIYqaHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2h2c21pbWVjYTEuY3JsMA4GA1UdDwEB/wQEAwIFoDAdBgNV
HSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwDQYJKoZIhvcNAQELBQADggEBAG7GEcPrcRoMakd1
k8cdl7NUgGsEGoTzcS1ASh1ZaKlEzGR0uHyB7QwpX1hSHCvUKMRAqe5vXqZWhVhiPNPc0792yPHo
K+K5sV1W+pF66TlYY/9qlz0IDyKlMRKyCkc77PdrXubuJjauu2WGnbDpHvVwLTqwwlR5O0OLig48
m4YUSo869xADdrGrWJ7KzroFbucLZYh3niIjVICp7fh9wtLgbX7X/akdubehYhy/l+AIMml6Zlyu
GNGCGIleyQ0bAdjjG+dKrDErUlui8wd/YplvelaTAzSvNpxcrr+2YB8UBWcYkgULkp5GDCC2guKl
rMF1mTS6N6GMxUi30sZicbMxggJeMIICWgIBATBcMEwxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMSIwIAYDVQQDExlHbG9iYWxTaWduIEhWIFMvTUlNRSBDQSAxAgwvfEOc
7N3JjQI9nAwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEII7yYNltdFFrvWcUhb7T
IyD9j7NE3bbxyzPmCS9l94+QMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTE3MDEwNzAxNTMzMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQADdYUOF4YnpNcxbx84jFcQCy8B7QA5HqGXS/gy
fOOYp4QgUAcoNAbjesipMwhjlz6TXCNtSvvFUT1K+2H8CxEhXe9pulkjovb1j8r8UPxxPSxFRf+o
oSX53Ab6A69IS++E5pdH4CogXEW8kpsTq3wl9Fzs2c5MazxKRB31UPBEH2aPkpjQ3TSKoutzgRET
+owrYlv3SCJDx7F/sewJbrgej+k+t773nyLk8dvUxFWn2OyLM+qYarf963V7KN55qAjQVGV2yxyF
Ldnt/TSN/qU/+rnRjOMV0naFf4prHXu9Acq5ea62XebPFzaJylqc9Qv9T4LMzSnQU1qRnqPyuOIl
--001a11402d82c251190545776641--
