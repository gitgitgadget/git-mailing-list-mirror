From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 6/9] for-each-ref: add '--merged' and '--no-merged'
 options
Date: Tue, 09 Jun 2015 00:24:00 +0530
Message-ID: <5575E4C8.70101@gmail.com>
References: <5573520A.90603@gmail.com>	<1433621052-5588-1-git-send-email-karthik.188@gmail.com>	<1433621052-5588-6-git-send-email-karthik.188@gmail.com> <vpq8ubursrh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 08 20:54:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z22BW-0003tH-WD
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 20:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345AbbFHSyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 14:54:07 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35058 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106AbbFHSyF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 14:54:05 -0400
Received: by pacyx8 with SMTP id yx8so65930245pac.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 11:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=oBpBp6jmDbCxw0cl2JS6RRYG9MLqcdMppMBbElt6L0E=;
        b=rZ2nHbQgBCCTMpOV/Gf+wqTrmEnTAl8BlnRx4pxg5qWLUKujEi+TOCkyFaK6zMOzvi
         6O7Hc48PwMyYT6jdYxpq8rKeboVJTeVlB6d/9CjbLddih9k0ab6tmWg7f4L0n12jexGL
         w6lfbWpEh4TyZCPUYb7YFr6XaZnXwHsQf0Gz1QYE0Wb5osJ/PX8JbuimfkKuizoIUBb+
         Tuke8jZfxWFasiW3+tP5saMcxOAyUBu7zsJnB+QgBb9qHz7kXOywJBdksOlKQEr8pJBE
         EJltPKYE+66/gBQOGjoTEqUcxFjw6UMWIZkTdUSjDozfo8dwPprzxil/hI++Xx3Rd2s4
         985g==
X-Received: by 10.66.136.78 with SMTP id py14mr31923865pab.1.1433789644694;
        Mon, 08 Jun 2015 11:54:04 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id s1sm3294825pda.54.2015.06.08.11.54.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2015 11:54:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpq8ubursrh.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271109>

On 06/08/2015 11:23 PM, Matthieu Moy wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Add the '--merged' and '--no-merged' options provided by 'ref-filter'.
>> The '--merged' option lets the user to only list refs merged into the
>> named commit. The '--no-merged' option lets the user to only list refs
>> not merged into the named commit.
>>
>> Add documentation for the same.
>
> This also requires some tests. The algorithmic part will be validated by
> 'git tag --merged' using this library, but you need to check the
> codepath from the command-line to the lib in for-each-ref.
>
>> @@ -38,6 +39,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>>   		OPT_CALLBACK(0, "points-at", &ref_cbdata.filter.points_at,
>>   			     N_("object"), N_("print only tags of the object"),
>>   			     parse_opt_points_at),
>> +		OPT_MERGED(&ref_cbdata.filter, N_("print only merged refs")),
>> +		OPT_NO_MERGED(&ref_cbdata.filter, N_("print only not merged refs")),
>
> I'd spell that "only refs that are not merged".
>

Like I mentioned, no tests were written.
Will change that.

-- 
Regards,
Karthik
