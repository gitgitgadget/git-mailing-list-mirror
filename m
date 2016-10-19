Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9434A20986
	for <e@80x24.org>; Wed, 19 Oct 2016 22:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932558AbcJSWW0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 18:22:26 -0400
Received: from mail-bn3nam01on0100.outbound.protection.outlook.com ([104.47.33.100]:50703
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932458AbcJSWWY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 18:22:24 -0400
X-Greylist: delayed 3568 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Oct 2016 18:22:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zebra.onmicrosoft.com;
 s=selector1-zebra-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ysDF0YNGEIlsqUx504TG85h5mNlKzG0/KE+AA79U6U4=;
 b=s4ixUb1+bIJrNAL5OGq7NOUlkK3ts0s6bUMpJ+Yt0c/MPDOVjlfEKaTaYIuRtUpR+OmzmW86vCN4Lj/yYi/W+I1id7U5SVHTgE5U2LPUOPCPfhWRPYN7JDKdieyLY6KTL9zPLY3/aJs+rs3uuvk+JVsJE2kaqWg68vbv0mM+Hmk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=CNP637@zebra.com; 
Received: from zama.local (140.101.111.1) by
 BY2PR03MB523.namprd03.prod.outlook.com (10.141.143.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.16; Wed, 19 Oct 2016 20:49:19 +0000
Subject: Re: Problems with "git svn clone"
To:     Eric Wong <e@80x24.org>
References: <500ef24a-55f9-1b38-52bb-17347ebaabcd@zebra.com>
 <20161019204118.GA5982@starla>
Cc:     git@vger.kernel.org
From:   K Richard Pixley <cnp637@zebra.com>
Organization: Zebra Technologies
Message-ID: <dea3ab60-be6b-ebcc-1047-6ab28a25979b@zebra.com>
Date:   Wed, 19 Oct 2016 13:49:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
 Gecko/20100101 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161019204118.GA5982@starla>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [140.101.111.1]
X-ClientProxiedBy: CY1PR10CA0012.namprd10.prod.outlook.com (10.162.208.22) To
 BY2PR03MB523.namprd03.prod.outlook.com (10.141.143.144)
X-MS-Office365-Filtering-Correlation-Id: f515838f-5893-437a-dab1-08d3f86166bf
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB523;2:KQHRvUX1YVp1pasLpZJP8Z7IC9YtMl0iySelulMb+lp1VxEAFJhpNABu+WGpYvE9I5C9WEMxIloDff1iRRk9uSRRLON7d0YNxdumN//HChvtDgOlI9wbXU2Vb+oEBpMP6cl+tsxscQEOEgAfdATHUxqH7zGV9zfQiJgdhWPiiqs5OIEhTNfV3YCvKmWT2SRt0UnY23CpWQbDAhdX4lm5ag==;3:kd/tQfrHXKpG3FpklRCmWMko+P3VRhNdg41ml4QG+BQf2Vqj7TblII4z1X/QbVqV/EgMW0eyDeTCo8IbGhOH7dHGtD0nM0MJaOAWlYaXyOg/4NmhHUkdpNUtet3nizcAV1vXRtF5LzzzXixdF+VIlw==;25:xFXfl2d9WFXYZ5swD3XbyLo3P4+PQ0IyPRqmhxuzdeLl/MZcqa/VpjgE9Xl0lKZX2GCIozZPy0h0/gJxpMUzQs7qUEx+o1Y9s1Y2sBfJfVZQ08wrIJ+Ipy+1drnqY3izNmRArsUfC2OexiFizCptX5pv7UDrVVYofZmJ4sruYfdoXMcId3H7giFaM1JQb0vzksLAK5Hh+5HelP9lmqHRREi0Jt0WJj3x+RIFFzd83W2/fBRqdnwfYrI2yoSBhb+5/sDxiqOY7iKU5xqNcPa5fhL0zOyF0KQQgMfFb6uYdhMUqoLIWbkm6cmR/Qrn0kobZBTs6LyIQzmjkEjXW5X9OhclEiswFIggs3SjP8iOIGZa4CqoW6+hvjw2spOtr1xu4j0Bhwbqh7Brxcvv/ah8oPMNkoxzz6KxKv9Q9iFM1uvgLJHPcjW0S+XwxaZ9Seq6nWlr0hrZ+dN8+oX2ixJPlA==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BY2PR03MB523;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB523;31:LOA4qU69it+IVFmOlrCaj+4zu/xc5AOeQWTq/rH841VnP0UGVk52p/3QhdNEN1gjWg6cR9L6oC/QoNnmCXFtZCOLD272cJAAKd21mg4ZWcm20Lu9CE/L3oN/ICcMEalt2z9A1IFavDkVIEM5crZAOZ9dMBFr7/RNMwheUMzB6N3fQ/UzG3Z3ryGCKT/w2qxI9S+4zSj5OAAOv6XLaclf3y6UOwtXNBE2QOBH4HRk8Hpw6eACnDug+zek++Flla4XZCez5wRPoCIBbbbb3NpnBA==;20:DLuCMENAWgwM6V/yOwWTBX5Ojk5Dsrv1cqpxB5a0PykevNxtFWzUHab+Voy3Q6h5MKukP1x1gEmFjqvasH3s3s6+/9JIywPUX+WCuDv+O/I/+D3mBvWBiqZbqaomS9MXzTZt5+S1gq3ffaH2jfFUipHBNfoUwewA4l/046XkP6+HzOcqflqWKjz7XtykVtQubqQz6+L0Of7Fyao+5gDDp5VKVNJqAc0rYMWuAQ561jCNEAQXXOVDIfLp3X5op+RJLPrPAtohgwAK5s5NcioIppFAXopg+ZglelYfV1wGXXHh6wCWR2D/haUdt0AnNpBouB65Y5yii8GH8XBA16pK1HDwbE4m3KpyIZqVWJoyt2hNZzFZhbuPF5c4tZarpDZ3jQQIhgRmoZl7i/4F/epgCaAu5OfCCRna5FTspJSihFdmlZExyqgzxG9YuNDume+XkiT0Un+gOpiHlCsaFbtqajZtgokg1UEqlGAfLCLdenQcG/Xrqn7Hv9d/k1yuUJ/R
X-Microsoft-Antispam-PRVS: <BY2PR03MB5238E524FACD5B6214829CE94D20@BY2PR03MB523.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(212694052984031);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6055026);SRVR:BY2PR03MB523;BCL:0;PCL:0;RULEID:;SRVR:BY2PR03MB523;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB523;4:3V4ZlociIWDaMG6+fTi7sWoC8rMgunetRTHsHsOpZsm+yxzt54LVUnFkA0v9wvKTexD+RFQNLIB0dk+8F9oQCb/cdpfeMYruuHpJzo9jbcR/o9Y2WGm0+1qn7QjUPSS4/2hFTzY03XEj/vzIZp7Tejg9SWL3nCH5+x5Lwty0KaidG0rfK2XFk5YCgN8pgcrJyjJWQV3hOkKJcIDZvdyvJQLluFALjfjISZM/FCIVIW54NLCkFXIQaSRl6uPKq1qK5MtbqsEmVQfuUqyLaJ2lpmY1lN2r3H0O4HtDM9UuLcoRPmuWkMhwGAmH7QXIutnPrSLCaGB4x+1YE3+As4gz9WeHuq2X8VHFzkO+eSOlBnpuxjklSnI7ByNdcLHfp4przkDzK/l8IRcrz4SeKlVOIjCKVDBZHBXP+0H6dAuOrJ6uf3ogYo5mm+7xLtxELaHDEmmJoScnYvEBGMjoBDUYmg==
X-Forefront-PRVS: 0100732B76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4630300001)(6009001)(7916002)(199003)(40124003)(24454002)(189002)(64126003)(76176999)(86362001)(15975445007)(4001350100001)(66066001)(105586002)(586003)(7846002)(106356001)(65806001)(65956001)(8676002)(36756003)(305945005)(97736004)(7736002)(47776003)(81156014)(23676002)(83506001)(33646002)(42186005)(19580395003)(6666003)(101416001)(19580405001)(2906002)(6916009)(31686004)(5660300001)(81166006)(65826007)(2950100002)(92566002)(50986999)(68736007)(6116002)(110136003)(3846002)(8746002)(50466002)(189998001)(31696002)(77096005)(54356999)(781001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR03MB523;H:zama.local;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: zebra.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAzTUI1MjM7MjM6Y3dQeVBTbDNVNmhxL0ZjOGRGanlLblhYZkV6?=
 =?utf-8?B?dk14WnYxVjFxY0JEQUpBU1NhOWRNRHovU0lUN2NvaThoOCtnY0RIWkNvUkZ1?=
 =?utf-8?B?MXhtMHBwMm1qTmJBNHB0R2hRQUF4YXZid29Va2F0VGpGV2swRnl4ZDE2cWlx?=
 =?utf-8?B?NkJDL2N6dmd5UmVrRkVac2dhODB0U3JRWmxJZEUzQ2FqZ3dYQ3FWU3VYSEVr?=
 =?utf-8?B?enFXUHhmQ1R6eFBINEZudTFIWUlLS0NrVWRLMW5xL2NYNEdpRHVPbjJiTGNR?=
 =?utf-8?B?dnVGWGtEaWZ4NjhkdXlBUHZjcFlyVWZDNWptRzZrYnU2Vy9UbGNXVDBiRmFz?=
 =?utf-8?B?SWpZaEFlcnIzazN1b1c2RG16VTZhMmtFdHQ3THBjNDJPSlRkTTRoUnUva2Ja?=
 =?utf-8?B?dkhJTFl5bktJdThqcVh6THBOeEVXaVo3NmVyYnhxTW0vVTRvMzJIcTBZL2Fh?=
 =?utf-8?B?bUp5RUV4Y1Z6L21mWkRtK0ZnKy9pN2tONzVjUlpsdnJHS1lkV1NGd2ZzTHEx?=
 =?utf-8?B?SHErN1A0aXhHWkhEc2o0SW8vRG9KQWRSOXhGSElpZjF3MVNTdW10UWhTR2Ix?=
 =?utf-8?B?Ulcyd2t0Z3ArUHRraXZERCsxL3VIdkE1M3VMR1lFZlg0WlVVNFp5MXczeEdO?=
 =?utf-8?B?ZEFqUDlsOXZtdi9NTitCM3E4dnFXcndHZWI2eGZmaGlFQWNvR1BvK0pRVGF3?=
 =?utf-8?B?Q1FVaHEwc2x6NEdXTW1XMjJEanduSjRQK1VnaWtTbHM4R0xpbENIWWFVVmor?=
 =?utf-8?B?Snl1MGtwTTFMMHpnSXZyRk43d3MzQkthS3phUERaWFU1ZDlZV2VERWU3NzFl?=
 =?utf-8?B?QWltajM2ZGxoTUFqVllDSHJxL0VITHFrdHlvcTFSb0VrYVJMemVZdDB2eHRq?=
 =?utf-8?B?d2cxUmRsR3Qzd0N2ZXp3YVpNSGpEUlNjRGdNSHFNRW56cFErYmlHeHRjc0lE?=
 =?utf-8?B?eEtNRWZHZjBINkF1Y2YvYVhZdk93cDNZZEZlTlRzU0MxMzhWMGpBVXlBbnVv?=
 =?utf-8?B?RHB3RDJOZFdrWFdDVmswcnhNSEc5Q0dqaVo4NWJJRjVXYjRHN0ZtY25HdjN6?=
 =?utf-8?B?VUxpcjhyY0dKaXpER0pyNFYwNkx4REdFOVM5WFBmRC9Sc0k5cHpMeDl3VXNO?=
 =?utf-8?B?cFd4LzU5bEFyN091dzFMMmxXTEtiS1BJOXVGaVhWeGRtSWNvaHY2TWdQb1JI?=
 =?utf-8?B?Ym5oTGJ1SVVkV293a0cva2JqMVdoNis4L0Z4MGxpYmozN1Y3WGIwQjB0OEx6?=
 =?utf-8?B?TUNTeU5KSGZrdWlpVWtlY0ZZVzdIMndLN1ByTmJTdXVXU09UOVpGdXg5K2NU?=
 =?utf-8?B?V2krUU95VzhxcXM5cVVxYlRZVWJUYnhXbjlhTWdxaFR4Z3BoS1pvM3JJSkk1?=
 =?utf-8?B?NGJLbU1OOE54TmE2THVMNVU5K2l6NGhwY2VCcEpuTmIyS0d4Q05CTUpOeEEv?=
 =?utf-8?B?TEZmWkU3djdHVzBJWTNUQUc0S2x3bHYzZy9EQzlKMTE2OFRiVkZEQWFIN0JO?=
 =?utf-8?B?OHRGWGhWWVNvRXRJOFpWZHBneTF4VWptd0hBZDlwcmdQT0szSEhTYjl6ckRw?=
 =?utf-8?B?RTYzU2d0aEFjM2hSeThWTXhlb01Pd0RDa01RSTVFbm85Vjc0bXIySUFJbkJZ?=
 =?utf-8?B?U3d2dFR0YjFPcVZ2TjBsbUE2dlV4bGNxYjAwR05CMFRVTHRxbk5jRTZnaEdQ?=
 =?utf-8?B?RFQreEtwWi84K2tIZ1JiT0crY3Z2d2UyRDh0WDdNbmhZc1UzZnBPeHNheVps?=
 =?utf-8?B?SWJaQWFTMjNadkhnVDZRPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB523;6:7+RZd2JwhalBq4hzILBeQ6db47yUdVKv/AJoOuEphIeliQMV1djah/aB3fV0GeozH1c9ESvKKxRaGy0HEgJevWX8gA3tB85KxO+R0LRbw0yfC2N5DUGAcUSfc8X3IUGzBXnFFonh1NjiLPOztz59R97DoSQCzd/cupjo0kRbxCzlTKGuGLtWVgG+qM79LGK7mkSGu4wpUQ7VflSm82hjDK5UIO37gqkNDFjVAF92a5Ck4Tz613rrzA6EQCdSFr10BXOZqGDPui6iIXXtL6dLhKYvWUSHoOmyhiV0WTF/K9tC+Qp66QKXlGivM37Wu8fqMqSm+cXg8jT4g+J6CBG/Ydj+bo+uuJE39Z1C0We+CNQ=;5:yJOx325Tip7cn5c247JW7zSLtonLcCct3hi8vr9ZGWfj5PrOe+y3hDQsiiR1ncvzX9aDGRqqfbAGxlgaN1WljB2Gaylz0VBlGopQZVx6xyH9lttTzw4ORcN4Kwoyh55MbFuaWZUCp+alz5cKGu7ydw==;24:22+RbAKTjbtrUd1C4QkTU6pwlYxVrgW+wvZBBd7m7yJdlfMS8shLy5dwXKd/DWtciOToUUEFer4TkJri6nT3H0diplMXUCZwrWm02CULzJs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB523;7:xJ7v0pOr8zbeLfNq/NCicE3FF9QzdoGEvikxxnwCBTNI+KS5KuEftR5S6wJQwOf3aUUkDqgHKTj49NiqNyIYhfzSGoJSFTSh8jgg3Fx0k8DkhlAdVWidoqSaqxPmhjSBDQZyU4youaLdHi+wkkVQeC6WRinl4QMJuLJJJNdNvq8efvaqE9/jw6/CHYOgGOhpPaUByawbkZ7BlV8WE+Hvme07VxrqNohJW8FpGTXvcusZRAUzeA5wu5/imfVeM1DhzlPtuzpWzweameMOGdjhHDUu+tCNyj+bjocBT/k5+Uwvi3SKlggoNWWW5wCdzf4X6U7l+DhnggeVcDCxGLwwQ96WOSCTrmxImJJuw7djVIU=
X-OriginatorOrg: zebra.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2016 20:49:19.9069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB523
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/19/16 13:41 , Eric Wong wrote:
> K Richard Pixley <cnp637@zebra.com> wrote:
>> error: git-svn died of signal 11
>>
>> This seems awfully early and blatant for a core dump.  What can I do to
>> get this running?
> Can you show us a backtrace?  Thanks.
There is none.  I ran it in gdb and bt produced no results.  Nor did the
thread send bt command.
>> Initially discovered on git-2.7.4, (ubuntu-16.04), but also reproduced
>> on freshly built top of tree git-2.10.1.445.g3cdd5d1.
> This could be a problem with the SVN Perl libraries, and should
> be fixed in newer versions (not sure if it's made it to distros,
> yet):
>
> https://public-inbox.org/git/0BCA1E695085C645B9CD4A27DD59F6FA39AAD5CF@GBW=
GCEUHUBD0101.rbsres07.net/T/
>
> Seems like it is fixed in latest Debian, maybe it needs to trickle
> into Ubuntu: https://bugs.debian.org/780246
Thanks.  I'll try adding that.

Er... which debian would that be?  testing?  Or sid?

--rich


________________________________
- CONFIDENTIAL-

This email and any files transmitted with it are confidential, and may also=
 be legally privileged. If you are not the intended recipient, you may not =
review, use, copy, or distribute this message. If you receive this email in=
 error, please notify the sender immediately by reply email and then delete=
 this email.
