From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: Re: [PATCH 7/7] run-command: mark run_hook_with_custom_index as deprecated
Date: Tue, 11 Mar 2014 18:37:38 +0100
Message-ID: <CA+SSzV3z5zQaEgJX_LC6j7FmfNYi-eC_7_UA=KWQBBooOpkgBQ@mail.gmail.com>
References: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
	<1394477377-10994-8-git-send-email-benoit.pierre@gmail.com>
	<20140311010039.GD4271@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Benoit Pierre <benoit.pierre@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 18:38:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNQcx-0001zk-Q8
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 18:38:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644AbaCKRh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 13:37:59 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:59136 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754851AbaCKRhi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 13:37:38 -0400
Received: by mail-ob0-f180.google.com with SMTP id wn1so8775036obc.11
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=IIIv49IUZ+htKzu4NENdZcyLCEo8t5HWFVKDFUR5rrQ=;
        b=pAk1cswscfV52Z08WizAQXDTzO8+KGJ/mYU7oD7Le4I+ZBkwIRM3hQflEeeBSTMlCE
         /upDtGZq9L16XuvAnqFprF5mtNwpisdZ1QcdBRERiK8R2+YtPglvuiq9YAe6fSpZEAl/
         q8ZZRll6q3huj9CiMZIQBErojFAm9ti5PsZs5siGUIWQJ3turG8qYG5p7zXmxWfLsPdi
         PK4pxZWdsJeTtCbFCNTwNEYZp0joZW1Kan6WLjmJrSuURznSMdaoMp3WaVifJGXU0Mmv
         v8bOop7fuogCaY3IWDyPQT0Gd60geD6rCFGL3R7da9K82TfdhjUO+W3qAb/4RZOW4DYm
         T1Qg==
X-Received: by 10.182.22.18 with SMTP id z18mr11767556obe.42.1394559458388;
 Tue, 11 Mar 2014 10:37:38 -0700 (PDT)
Received: by 10.76.94.143 with HTTP; Tue, 11 Mar 2014 10:37:38 -0700 (PDT)
In-Reply-To: <20140311010039.GD4271@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243872>

On Tue, Mar 11, 2014 at 2:00 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Mon, Mar 10, 2014 at 07:49:37PM +0100, Benoit Pierre wrote:
>> ---
>>  run-command.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/run-command.h b/run-command.h
>> index 88460f9..3653bfa 100644
>> --- a/run-command.h
>> +++ b/run-command.h
>> @@ -51,6 +51,7 @@ extern int run_hook_le(const char *const *env, const char *name, ...);
>>  extern int run_hook_ve(const char *const *env, const char *name, va_list args);
>>
>>  LAST_ARG_MUST_BE_NULL
>> +__attribute__((deprecated))
>
> It doesn't appear that we use the deprecated attribute anywhere else in
> the code.  Wouldn't it just be better to change the places that use this
> and then remove the function altogether?  I imagine your current patch
> might introduce a number of warnings that some people would rather
> avoid.

This last patch is optional. There are no callers to
run_hook_with_custom_index, so no warnings for now. See discussion on
first draft as to why I added it:

http://article.gmane.org/gmane.comp.version-control.git/243561

-- 
A: Because it destroys the flow of conversation.
Q: Why is top posting dumb?
