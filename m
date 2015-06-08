From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 4/9] parse-options: add parse_opt_merge_filter()
Date: Tue, 09 Jun 2015 00:24:28 +0530
Message-ID: <5575E4E4.4080403@gmail.com>
References: <5573520A.90603@gmail.com>	<1433621052-5588-1-git-send-email-karthik.188@gmail.com>	<1433621052-5588-4-git-send-email-karthik.188@gmail.com> <vpqoakqozdr.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 08 20:54:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z22By-0004Jy-2X
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 20:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393AbbFHSye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 14:54:34 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33884 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106AbbFHSyd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 14:54:33 -0400
Received: by pdbki1 with SMTP id ki1so110687621pdb.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 11:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Sm1psO3aCUr1X7ccdDKrRShi6RyD0iC3FdE4hoHz2Gw=;
        b=h6zWptCGxp8BbSrO9myA7rDzBL6qyDuHw/Ifm6b53iw5aQuwTaV0FCcN1lmpK0cDIU
         hvuUkfYEOhb57IH9BpFy4ncWgTKfElWOjKP8JuTMA9ULpofL96aAbcaXi94v1qyPBvur
         cm+MQ8epqT/+c6xQBiXx6MvqIW+gm5daAKwK4iEOPuduVmjYZTbK+YV/BU408bOtNKcI
         2FnZ3FVNMhX1uAmS8bN0XqjGzMOrgft7NU3S9yVp5KonbJ3wf+lxI8NrOPgz6TF9Zhyf
         l4MfdVvPVXUyem3FNQ8OwcjPvW6AVz6d+1S2DqCjnboCYDDOSxwX9i3zjsA/s8k8jRSO
         KYlA==
X-Received: by 10.70.90.103 with SMTP id bv7mr32430772pdb.160.1433789672538;
        Mon, 08 Jun 2015 11:54:32 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id fb3sm3277643pbd.91.2015.06.08.11.54.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2015 11:54:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpqoakqozdr.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271110>

On 06/08/2015 11:28 PM, Matthieu Moy wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
>> +{
>> +	struct ref_filter *rf = opt->value;
>> +	unsigned char sha1[20];
>> +
>> +	rf->merge = opt->long_name[0] == 'n'
>> +		? REF_FILTER_MERGED_OMIT
>> +		: REF_FILTER_MERGED_INCLUDE;
>
> I would use starts_with("no-", opt->long_name) instead. I had a hard
> time understanding why the letter 'n' was special while the
> starts_with() version is self-explanatory.
>

Can do that also :)

-- 
Regards,
Karthik
