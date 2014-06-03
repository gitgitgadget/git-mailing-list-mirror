From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH] config: Add documentation for writing config files
Date: Tue, 03 Jun 2014 01:43:37 -0700
Message-ID: <538D8AB9.4010800@gmail.com>
References: <1401715621-3681-1-git-send-email-tanayabh@gmail.com> <vpq38fnf6go.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@Grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 03 10:43:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrkK6-0007Dv-6K
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 10:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbaFCIny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 04:43:54 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:53667 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbaFCInw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 04:43:52 -0400
Received: by mail-pb0-f44.google.com with SMTP id rq2so5264631pbb.3
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 01:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=NO3pR9YN9KPGzozJ+u/65WUvEDQa5+a3b5PFclEwqVc=;
        b=joWCQ2JX2barJ3aUaL6qBuNmFFQ0LIh3MpD1XkOR8sCyf1FPk6AcQFbJ2y3iVIIuC2
         0G5j1LvulSxqTHX1yMgEcJqGunpt3sJYx/SFba4ci4EEV20T87gcM2qNUE+rHZYcu18J
         uFvVXm+YvDaKdxH7HeWUA2MEmMNZTyphbJil6+tqm5kAM7Ch+N3Fy0Hmn3tvxFe9cRKg
         kYkwN8FpbmFlUtt1LkTf9enENrs7NtAUYxbBmvkHYWMfsqH59j04RZyh8ss7L/sR6gy4
         cziQAya1DKyKomWdhSFsQp1hk5y4u40lDdN54Ybw4dS8Zqd0lFfwfug66RgX0S75IxKJ
         KDEg==
X-Received: by 10.68.171.193 with SMTP id aw1mr47128597pbc.117.1401785031905;
        Tue, 03 Jun 2014 01:43:51 -0700 (PDT)
Received: from [192.168.52.160] ([117.254.217.85])
        by mx.google.com with ESMTPSA id zx1sm8422540pbc.60.2014.06.03.01.43.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 03 Jun 2014 01:43:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <vpq38fnf6go.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250621>

On 06/02/2014 12:37 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
>> ---
>>  Documentation/technical/api-config.txt | 31 ++++++++++++++++++++++++++++++-
>>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> Even though the reason to replace a TODO with real stuff is rather
> straigthforward, the reader appriates a short commit message (ideally
> pointing to the commit introducing the TODO). My first thought reading
> the patch was "wtf, is that a patch in the middle of a series, where
> does this TODO come from" ;-).

Ok, I will send a new patch with the updated commit message. .

>> +In the end they both all call `git_config_set_multivar_in_file` which takes
>> +four parameters:
> 
> Do we really want to document this as part of the config API? i.e. does
> a normal user of the API want to know about this? My understanding is
> that git_config_set_multivar_in_file is essentially a private function,
> and then the best place to document is with comments near the function
> definition (it already has such comment).

Sorry, but I don't think so. In cache.h, the following functions have been provided
as externs,
git_config_set_in_file()
git_config_set()
git_config_set_multivar()
git_config_set_multivar_in_file()
extern int git_config_rename_section()
extern int git_config_rename_section_in_file()

Thus, they seem to be the part of the API. In most of the technical API docs I have
read there is at least a description of all parameters of the main function also,
relevant data structures if any.
Also a certain amount of redundancy about details is allowed.

A good example is api-hashmap.txt which provides detailed descriptions of each
function and data structure which was very much helpful to me.

Reverse is api-string-list.txt which was useless to me, so I had to go through
the whole code to understand how to use it.

Thanks for the review.
