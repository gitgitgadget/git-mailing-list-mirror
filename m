Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 743DF20966
	for <e@80x24.org>; Thu, 30 Mar 2017 21:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934373AbdC3V0L convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 30 Mar 2017 17:26:11 -0400
Received: from mail-oln040092005050.outbound.protection.outlook.com ([40.92.5.50]:28731
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934107AbdC3V0K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 17:26:10 -0400
Received: from SN1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (10.152.72.54) by SN1NAM02HT063.eop-nam02.prod.protection.outlook.com
 (10.152.72.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.1005.5; Thu, 30
 Mar 2017 21:25:58 +0000
Received: from CY1PR19MB0128.namprd19.prod.outlook.com (10.152.72.60) by
 SN1NAM02FT025.mail.protection.outlook.com (10.152.72.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.1005.5 via Frontend Transport; Thu, 30 Mar 2017 21:25:58 +0000
Received: from CY1PR19MB0128.namprd19.prod.outlook.com ([10.162.42.148]) by
 CY1PR19MB0128.namprd19.prod.outlook.com ([10.162.42.148]) with mapi id
 15.01.0991.021; Thu, 30 Mar 2017 21:25:58 +0000
From:   Varun Garg <varun.10@live.com>
To:     "gitster@pobox.com" <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: =?Windows-1252?Q?[RFC/PATCH]_Make_=93git_tag_--contains_<id>=94_less_chat?=
 =?Windows-1252?Q?ty_if_<id>_is_invalid_(gsoc)?=
Thread-Topic: =?Windows-1252?Q?[RFC/PATCH]_Make_=93git_tag_--contains_<id>=94_less_chat?=
 =?Windows-1252?Q?ty_if_<id>_is_invalid_(gsoc)?=
Thread-Index: AQHSqZw5ujFdKhux1U+6e1vmfwmqkA==
Date:   Thu, 30 Mar 2017 21:25:58 +0000
Message-ID: <CY1PR19MB01289DCA6C08CDC9F07C6D7DF2340@CY1PR19MB0128.namprd19.prod.outlook.com>
References: <CY1PR19MB01287042E66B0DA09D554513F2340@CY1PR19MB0128.namprd19.prod.outlook.com>,<CY1PR19MB0128EB66B1C7FA67E601E3DEF2340@CY1PR19MB0128.namprd19.prod.outlook.com>
In-Reply-To: <CY1PR19MB0128EB66B1C7FA67E601E3DEF2340@CY1PR19MB0128.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=live.com;
x-incomingtopheadermarker: OriginalChecksum:AECDE86F841CD22AA59CA6AB75827C254F7458EC40AD81FD99DEC984207267F5;UpperCasedChecksum:33AF1C4AABFF277D9E501535D235B07A352C315525AF34C5090F1E714E7E02E4;SizeAsReceived:8391;Count:42
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [KFcMIMn1b1C/a7sE2G00c55n9gOBofl5]
x-microsoft-exchange-diagnostics: 1;SN1NAM02HT063;5:x0CRTglyFz8fPxfy8Y5GGiOZhy0FbYFe9oN+rNoVbLNX5295C4By/WTm5whaq6T0j6M38FuNYdb2oasyq5MldaN9SZbaK60y3hCsVangninigEyUHdjPBb9teKhiM04ShYjUoR4+tIIodNjiHtHzWSZIeMME/M5AKKljUE5Sqmg=;24:F5Vv/gX7qGKHHdQ2ymSjuPNIDwiGlkomBhdgU73Xo/86fr/DDPkrrqhneWArnX070Vc34HbPy9WVBsPQXOvT8k4PiHczilQgCU8hlkUnJgQ=;7:hWu/5cCr/kokxMr0/KQSfQ4fzJiny9XHbse1bl6tHQ2bWlxMkqiC38742i+FPcPHxl6Y1HPr/noj6+AVsZrKQta4wGiiOv85EhpzRo/rRPjXiYpQcL2MbmEKheeKF17fAS5/2jsPsEq47GIMKglrkWylAjyo+h13xRjJQtKkkWVAEvtPn08n1rA50FC1i5bTk1+G8cijFVgLKqtW+So+AaYuT8Iamryd7qSbxzZpsvRw0bhFvOAOdXxD5pPkMqpZrwNRSnPEmwchvlwwcL7kGAYPWbLqotLl9Iu/7gNg5tlLmIMWycEWJh9UDSvOSm/5
x-incomingheadercount: 42
x-eopattributedmessage: 0
x-forefront-antispam-report: EFV:NLI;SFV:NSPM;SFS:(7070007)(98901004);DIR:OUT;SFP:1901;SCL:1;SRVR:SN1NAM02HT063;H:CY1PR19MB0128.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;
x-ms-office365-filtering-correlation-id: 5a392189-bde7-4c4f-dbcf-08d477b35b9b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201702061074)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322274)(1601125374)(1603101448)(1701031045);SRVR:SN1NAM02HT063;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(444000031);SRVR:SN1NAM02HT063;BCL:0;PCL:0;RULEID:;SRVR:SN1NAM02HT063;
x-forefront-prvs: 02622CEF0A
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2017 21:25:58.4273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1NAM02HT063
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git devs,

I am a student interested for Gsoc. With my patch I am able to produce following output.

    $ git tag --contains qq
    error: malformed object name qq

    $ git tag --contains HEAD qq
    fatal: --contains option is only allowed with -l.

    $ git tag --contains 5c5c16af33f3cba2f7ce905514c04c4e173b11dc
    error: no such commit 5c5c16af33f3cba2f7ce905514c04c4e173b11dc

    $ git rev-parse --verify qq
    fatal: Needed a single revision

This makes git less chatty, and solves the problem with  https://public-inbox.org/git/20160323224113.GB12531@sigill.intra.peff.net/.

Here is the patch

$cat less_chatty.patch 
diff --git a/parse-options.c b/parse-options.c
index a23a1e67f..603c77c61 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -160,7 +160,7 @@ static int get_value(struct parse_opt_ctx_t *p,
             return (*opt->callback)(opt, NULL, 0) ? (-1) : 0;
         if (get_arg(p, opt, flags, &arg))
             return -1;
-        return (*opt->callback)(opt, arg, 0) ? (-1) : 0;
+        return (*opt->callback)(opt, arg, 0) ? (-3) : 0;
 
     case OPTION_INTEGER:
         if (unset) {
@@ -506,6 +506,8 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
             goto show_usage_error;
         case -2:
             goto unknown;
+                case -3:
+                        return PARSE_OPT_HELP;
         }
         continue;
 unknown:

What I have done is, created a new case(-3) which is error but not to be displayed. In case 1, function usage_with_options_internal() is called which returns PARSE_OPT_HELP (and doesen't modify given parameters). So directly returning it from 3rd case should directly skip help text without affecting program behavior. This gave me the desired results.

However, when I run the tests, I get following behavior with cherry picking,


$ ./t3502-cherry-pick-merge.sh 
ok 1 - setup
not ok 2 - cherry-pick -m complains of bogus numbers
#    
#        # expect 129 here to distinguish between cases where
#        # there was nothing to cherry-pick
#        test_expect_code 129 git cherry-pick -m &&
#        test_expect_code 129 git cherry-pick -m foo b &&
#        test_expect_code 129 git cherry-pick -m -1 b &&
#        test_expect_code 129 git cherry-pick -m 0 b
#    
ok 3 - cherry-pick a non-merge with -m should fail

I have no idea where and why it is coming. (maybe it wants a more chatty git). Any help would be really appreciated since gsoc deadline is very close and I have to write a proposal.

Regards
Varun garg
