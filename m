From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: How to use --cc-cmd in git-send-email?
Date: Mon, 20 Jul 2015 02:06:17 -0400
Message-ID: <CAPig+cTsJQ+dK5M0S8LERkPWiipzxLYdbCK6-ghen1OkAX=NBg@mail.gmail.com>
References: <CA64425B296E41328D6A1F29E227A24D@PhilipOakley>
	<CAPig+cTQspD+0StY5tneqwekS3xCjdxcidoDA7Ztf26g-tMucg@mail.gmail.com>
	<8684534127894F239338493A7D15F46D@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 08:06:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZH4DW-0004JF-Hf
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 08:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755047AbbGTGGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 02:06:18 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:33415 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754994AbbGTGGS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 02:06:18 -0400
Received: by ykfw194 with SMTP id w194so51603922ykf.0
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 23:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=x2p9Oc73bH9c+lAtDW0NP5nzva5D81mDESA+mWrKJQQ=;
        b=Syxa/ck9BOEKzvDpQuj2gpbNazAHmO80JgVI/+RJ9DW7Fa3MtrbQaFWKigdNfkgoyl
         TrgnCryzaLGS2AOP6UmVK/tBmvRueSMZUj/Q1dHKpk0sNK8wj6EGiZ5ClsPYfhDLk3Bd
         vLm3kDoKK0ltcsrR4cGbaNUqqFjKHYQnHg15iw0fOF5OeSoSZc89wyCM90M/INUIgGcS
         uCiNTDpr2JtdS1Tb5nIZ3kuTs2YJzgXOgHr9qJog824KQb47OFmUyIBcAV2U/VKKrJez
         yoj45aXcsrwS7TalLgxAzumehhsUrXiAMjk7GPHJvyX4xHT+t2XONlY8fLjUlJLYwZwH
         pajw==
X-Received: by 10.13.192.132 with SMTP id b126mr26540276ywd.163.1437372377438;
 Sun, 19 Jul 2015 23:06:17 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sun, 19 Jul 2015 23:06:17 -0700 (PDT)
In-Reply-To: <8684534127894F239338493A7D15F46D@PhilipOakley>
X-Google-Sender-Auth: wTfjOKvjJNOhhV7cNr5vld-R0_M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274313>

On Mon, Jul 20, 2015 at 2:01 AM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Eric Sunshine" <sunshine@sunshineco.com>
>> git-send-email invokes the cc-cmd like this:
>>
>>    $cc-cmd $patchfilename
>>
>> so, when you used 'cat cc-cmd' as the value of --cc-cmd, your invocation
>> became:
>>
>>    cat cc-cmd $patchfilename
>>
>> and since 'cat' copies the concatenation of its input files to its
>> output, that explains why you first saw the names from your 'cc-cmd'
>> file followed by the content of the patch file.
>
> Many thanks, that seems to explain everything!
>
> I may try and do a small doc patch for the git-send-email.txt man page (I
> have a few doc fixes backing up waiting to be done ;-)

That would be welcome. I don't think it's mentioned at all in
git-send-email.txt that the --to-cmd/--cc-cmd commands are handed the
patch pathname as an argument, so that's certainly something worth
documenting.
