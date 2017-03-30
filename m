Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFCD320966
	for <e@80x24.org>; Thu, 30 Mar 2017 21:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933799AbdC3VeC (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 17:34:02 -0400
Received: from proofpoint8.lanl.gov ([204.121.3.47]:38873 "EHLO
        proofpoint8.lanl.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933428AbdC3VeC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 17:34:02 -0400
Received: from pps.filterd (proofpoint8.lanl.gov [127.0.0.1])
        by proofpoint8.lanl.gov (8.16.0.20/8.16.0.20) with SMTP id v2ULRpsq040445;
        Thu, 30 Mar 2017 15:33:51 -0600
Received: from mailrelay2.lanl.gov (mailrelay2.lanl.gov [128.165.4.103])
        by proofpoint8.lanl.gov with ESMTP id 29dnaydgn7-1;
        Thu, 30 Mar 2017 15:33:51 -0600
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mailrelay2.lanl.gov (Postfix) with ESMTP id 40564F7C402;
        Thu, 30 Mar 2017 15:33:51 -0600 (MDT)
X-NIE-2-Virus-Scanner: amavisd-new at mailrelay2.lanl.gov
Received: from pn1216650.lanl.gov (pn1216650.lanl.gov [128.165.243.37])
        by mailrelay2.lanl.gov (Postfix) with ESMTP id 29B3EF7C3FA;
        Thu, 30 Mar 2017 15:33:51 -0600 (MDT)
Subject: Re: ttk error when starting git gui
To:     Peter van der Does <peter@avirtualhome.com>, git@vger.kernel.org
References: <0fc69c73-73aa-5355-264b-a7c55377eec2@lanl.gov>
 <4addfbdb-1289-7958-87e5-8d8caa9febfb@avirtualhome.com>
From:   David Shrader <dshrader@lanl.gov>
Message-ID: <c4e7185d-cef9-ce1b-a944-e92e0d17249c@lanl.gov>
Date:   Thu, 30 Mar 2017 15:33:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <4addfbdb-1289-7958-87e5-8d8caa9febfb@avirtualhome.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-03-30_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1702020001
 definitions=main-1703300183
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 03/30/2017 01:54 PM, Peter van der Does wrote:
> On 3/30/17 1:01 PM, David Shrader wrote:
>> Hello,
>>
>> I get the following error when trying to start git gui:
>>
>> Error in startup script: wrong # args: should be "ttk::style theme use
>> theme"
>>      while executing
>> "ttk::style theme use"
>>      (procedure "ttext" line 4)
>>      invoked from within
>> "ttext $ui_workdir -background white -foreground black \
>>          -borderwidth 0 \
>>          -width 20 -height 10 \
>>          -wrap none \
>>          -takefocus 1 -highlightthickness 1\
>>          ..."
>>      (file
>> "/home/dshrader/opt/toss2/common/git/2.12.2/libexec/git-core/git-gui"
>> line 3190)
>>
>> I get this error with the latest released version 2.12.2. Two older git
>> versions are also available on this system, and neither has this issue.
>> Those older versions are 1.7.1 and 2.3.3. I don't see a call to ttext in
>> those corresponding git-gui executables, so that is probably why they work.
>>
>> Here are the steps to reproduce:
>>
>> 1) cd to existing git repository
>> 2) run 'git gui' (no gui comes up, and the error is printed in the
>> terminal)
>>
>> I'm running on a RHEL6 based system. Do I have an insufficient version
>> of whatever git gui uses for graphics in the later versions of git? When
>> I try 2.12.2 on my personal workstation running Fedora 25, I don't see
>> the same issue.
>>
>> Thank you very much for your time,
>> David
>>
>
> It looks like the git gui needs TCL/TK 8.6.0 or higher. Since that
> version the command 'ttk::style theme use' has been changed, which
> allows the command to be run without an argument and then returning the
> current theme used.
> I believe RHEL6 use Tk-8.5.7 but I can't be 100% sure.
>
Yep, 8.5.7 is what I have on the RHEL6-based system. Thanks for the info!
David

-- 
David Shrader
HPC-ENV High Performance Computer Systems
Los Alamos National Lab
Email: dshrader <at> lanl.gov

