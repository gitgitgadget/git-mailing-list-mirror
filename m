From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH v4 2/4] Add testcases for the --detect-dir-renames diffcore
 flag.
Date: Tue, 05 Oct 2010 11:21:58 +0200
Message-ID: <4CAAEE36.4060000@op5.se>
References: <1286138529-6780-1-git-send-email-ydirson@altern.org> <1286138529-6780-2-git-send-email-ydirson@altern.org> <1286138529-6780-3-git-send-email-ydirson@altern.org> <20101004203241.GF6466@burratino> <20101004213703.GW4983@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Yann Dirson <ydirson@free.fr>
X-From: git-owner@vger.kernel.org Tue Oct 05 11:22:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P33iw-0000Fk-Bu
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 11:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410Ab0JEJWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 05:22:08 -0400
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:58978 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932314Ab0JEJWH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 05:22:07 -0400
Received: from source ([209.85.215.182]) by na3sys009aob106.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTKruPMB2FslSfBi/dn0s4y24XOYnNsx3@postini.com; Tue, 05 Oct 2010 02:22:07 PDT
Received: by mail-ey0-f182.google.com with SMTP id 24so2866713eyx.13
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 02:22:04 -0700 (PDT)
Received: by 10.14.47.79 with SMTP id s55mr6988881eeb.46.1286270524222;
        Tue, 05 Oct 2010 02:22:04 -0700 (PDT)
Received: from clix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id v8sm8982909eeh.8.2010.10.05.02.22.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 Oct 2010 02:22:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7 ThunderGit/0.1a
In-Reply-To: <20101004213703.GW4983@home.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158180>

On 10/04/2010 11:37 PM, Yann Dirson wrote:
> On Mon, Oct 04, 2010 at 03:32:41PM -0500, Jonathan Nieder wrote:
>> Yann Dirson wrote:
>>
>>> From: Yann Dirson<ydirson@free.fr>
>>> Subject: Add testcases for the --detect-dir-renames diffcore flag
>>
>> Probably better for the test to be squashed with the patch that adds
>> that option.
> 
> I tend to agree, but we see quite a lot of patches split this way it
> seems.  Junio, any preference here ?
> 

Personally, I prefer adding the test first with "test_expect_failure"
and then changing it to test_expect_success in the patch that has the
real code changes. That way it's really easy to accept a testcase and
still keep altering how the test itself is fixed, which is usually a
far more complex and nitpickley process than showing that the bug is
there in the first place.

I know Junio has voiced the same preference for patchseries before and
especially when the solution isn't obvious. Note that I obviously can't
speak for him in any particular case.

Patches adding features should ofcourse have the code first and the
tests after, since the tests in that case are only about preventing
future breakage rather than showing that there is one now.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
