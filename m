From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv8 1/9] submodule-config: keep update strategy around
Date: Fri, 5 Feb 2016 12:36:55 -0800
Message-ID: <CAGZ79kaBQx-vTYAoaJe2wjXuEZpq10OtzHbfvRGGYKj2+V=zEg@mail.gmail.com>
References: <1454623776-3347-1-git-send-email-sbeller@google.com>
	<1454623776-3347-2-git-send-email-sbeller@google.com>
	<20160205005946.GA19501@google.com>
	<CAGZ79kYfxYAZif4P0GRdy5LQVXuHAyr3VtwEtX7Uu0sDyD4yoQ@mail.gmail.com>
	<20160205203309.GA28749@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 21:37:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRn7l-000320-Gj
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 21:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140AbcBEUg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 15:36:57 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:34780 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbcBEUg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 15:36:56 -0500
Received: by mail-io0-f181.google.com with SMTP id 9so141767286iom.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 12:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bLDyTIPAFR0UuzeWr+o6eO3nMFagWPeaPJI++B0JQBE=;
        b=ngIDdSSVwTi3YKEHMhyQleZayOPHhmFP6xQuUdNF9MHYbb+KwAk3sLJUaiIsyof/Ky
         dBOyd/Vc/G+MKi6S3yFHXaOVhrR7DhLWYx4f04Xg5bpMrqeDHpujy2jeD7DBOeG2i9W7
         jhC6j+/lP5U/vvfMa2XkuODM2VUFFnDULKzGqAYFvkPkWQFS4vNF40d8d81ZsuAF9txz
         nX0wzF0J4a54SCXvc0Qqxo+ygcdpm9VHpR+qywSHujcJ9EhW4a/qS20P17lFR2u89aPq
         ePqzr2yGpiFqOXb06TXcdEjciM92P8d0sEdpoP1l4dDVjyWmOV5FnXOy0gvYpCaDnbns
         08hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=bLDyTIPAFR0UuzeWr+o6eO3nMFagWPeaPJI++B0JQBE=;
        b=e00GrMhv5pwzxXt+4v6F/o5KBEtk8l82Fuf0GX69ER7HtUYQfWtZElrZBJ59VMB+av
         rwbzlpVru1bPdvO/5fR6cGwmAR699+/Rqm/HTCCvK/1ZVHJpUE5eI1Gr5pJuHEPr6nht
         85u7vO5CHGG6v9WFyHfH5ynYaLM8Rmo+CuJlN8n+jTkr1db36/ssi7DfI2Ryhf+Shbyh
         u62gGgG3HEHrsomM6QleDhK6/4I+SrUD9Lqk6pre08bJpZz2tQzbXxvcp6biPra1V2Cz
         waWawEmVxKEkofBLAJ4I1S8gE3GnfU3vgLRBayo4sFpvQSORTxWb68/CALPSwCMCbT6N
         zjzg==
X-Gm-Message-State: AG10YOQewx6wxIvDjZmwrqAFS1aTEgx8DoUiMwMnLLVM8/RcCdJBBS3wbs2QJNeUiTOtHBEW/m+V2zCYxoocOUOY
X-Received: by 10.107.158.81 with SMTP id h78mr16307239ioe.174.1454704615417;
 Fri, 05 Feb 2016 12:36:55 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Fri, 5 Feb 2016 12:36:55 -0800 (PST)
In-Reply-To: <20160205203309.GA28749@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285627>

On Fri, Feb 5, 2016 at 12:33 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Stefan Beller wrote:
>> On Thu, Feb 4, 2016 at 4:59 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>> Stefan Beller wrote:
>
>>>> +++ b/submodule-config.h
>>>> @@ -14,6 +14,7 @@ struct submodule {
>>>> +     const char *update;
>>>
>>> gitmodules(5) tells me the only allowed values are checkout, rebase,
>>> merge, and none.  I wouldn't know at a glance how to match against
>>> those in calling code.  Can this be an enum?
>>
>> "Note that the !command form is intentionally ignored here for
>> security reasons."
>>
>> However you can overwrite the update field in .git/config to be "! [foo]",
>> which we also need to support, so let's keep it a string for now?
>
> I had forgotten about "!command".  I think making it a string makes
> the field hard to use: how do I determine whether it was checkout,
> rebase, merge, custom, or none?  Are they case-sensitive?  Am I
> supposed to strip whitespace?
>
> One possibility would be to have an enum and a string:
>
>         enum submodule_update_type update;
>         const char *update_command;

ok, that makes sense.

>
> Thanks,
> Jonathan
