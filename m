From: Guanglin Xu <mzguanglin@gmail.com>
Subject: Re: [PATCH] branch.c: change install_branch_config() to use skip_prefix()
Date: Mon, 3 Mar 2014 00:01:41 +0800
Message-ID: <CAATe9uiCz_fe65=O_qVUX5OWbbFj4nqBZDsB_0dMt175HLCFDg@mail.gmail.com>
References: <1393761147-13590-1-git-send-email-mzguanglin@gmail.com>
	<CAL0uuq0Vc7uZdixLV6OciAZWFYcif_WMCNABEvC=6gT5s+mthQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun Mar 02 17:01:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WK8pn-0005SG-96
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 17:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402AbaCBQBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 11:01:42 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:62503 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbaCBQBm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 11:01:42 -0500
Received: by mail-ig0-f182.google.com with SMTP id uy17so5663034igb.3
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 08:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:cc
         :content-type;
        bh=RJvNOJEaAWAtKZZ2ikI2XIy7Rdg08gF1bA0XHL9jeOs=;
        b=jDEOg+spOEn5Z99iHsdu1S7Va3BcGrZzdAvBE85tTKUpmQ84SPOpx+Eo8gvwiZhbgm
         YAEp/oSucseM0exR1dvveAc3BS+Ipt95VLEw/qqNrCVtncHeUs9Zuip3J+Y4vwAwDOt0
         QwlhiYNkpsTawr2cMPFN31W1VHF8Ogv7l2dZWAnqkx3n4K4QSd4HmtLACe8cIZ5xDAZv
         XJkvvdPjBT5RHpPnoeYp2lwur8B/46NmA74fn/l8k10jrh42RvMRfmVmI6nfKMfQWWKY
         15vRFXs/5zqOvhqn9l5RBzM0hHaiYyelWGiF1CjgJh/HTONgTYxX0j3R6OwDm+fJMDFA
         RJDA==
X-Received: by 10.43.163.2 with SMTP id mm2mr21942761icc.20.1393776101612;
 Sun, 02 Mar 2014 08:01:41 -0800 (PST)
Received: by 10.64.14.135 with HTTP; Sun, 2 Mar 2014 08:01:41 -0800 (PST)
In-Reply-To: <CAL0uuq0Vc7uZdixLV6OciAZWFYcif_WMCNABEvC=6gT5s+mthQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243153>

Hi Jacopo,

Thanks for your comments. I just update this PATCH as v2. I appreciate
more comments from you and others in the new thread.

Regards,

Guanglin

2014-03-02 22:01 GMT+08:00 Jacopo Notarstefano <jacopo.notarstefano@gmail.com>:
> The part about this being a GSoC microproject should go below the
> three dashes, since it's not information that needs to
>  be recorded in the codebase.
>
> On Sun, Mar 2, 2014 at 12:52 PM, Guanglin Xu <mzguanglin@gmail.com> wrote:
>> GSoC2014 Microproject: according to the idea#2 for microprojects, change install_branch_config() to use skip_prefix() and make it conform to the usage of previous starts_with().
>>
>> Signed-off-by: Guanglin Xu <mzguanglin@gmail.com>
>> ---
>>  branch.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/branch.c b/branch.c
>> index 723a36b..ca4e824 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -50,7 +50,7 @@ static int should_setup_rebase(const char *origin)
>>  void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
>>  {
>>         const char *shortname = remote + 11;
>> -       int remote_is_branch = starts_with(remote, "refs/heads/");
>> +       int remote_is_branch = (NULL != skip_prefix(remote ,"refs/heads/"));
>>         struct strbuf key = STRBUF_INIT;
>>         int rebasing = should_setup_rebase(origin);
>>
>> --
>> 1.9.0
>>
>> Hi,
>> I am Guanglin Xu. I plan to apply for GSoC 2014.
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
