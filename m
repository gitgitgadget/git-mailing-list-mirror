From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 07/16] list-files: show directories as well as files
Date: Tue, 10 Mar 2015 13:39:58 +0700
Message-ID: <CACsJy8CU=gmaLL1Nvsai-gtH=Qz876ciiX7LTFgV2-zBRRz1ww@mail.gmail.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
 <1425896314-10941-8-git-send-email-pclouds@gmail.com> <CAPig+cSCTJH-otgWAQxwjwkw0SbP4OFXyDhUZs=0bzoL7B32ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"git@drmicha.warpmail.net" <git@drmicha.warpmail.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 07:40:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVDqE-0004ob-V7
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 07:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbbCJGka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 02:40:30 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33709 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbbCJGk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 02:40:29 -0400
Received: by iecvj10 with SMTP id vj10so1422654iec.0
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 23:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YInGupzJ0i9U5VA4LseYcZQS0Gh3sW1vuauvO+NsmYs=;
        b=UAGAiV9+mch8yRnikEWDNAOH2OuNLa0UvgHu+hfY7ql942XaBnn9+3yfWSVaYaAoNB
         SKrsvXMO0j0YowrNk+gwiZSJuwICj/1MFNpcGdiJc1D5nMvm+VyKds7qRT1IBwOTO8Fc
         B9KZKspeQsUK+p6MfRS+irGZ2OGD89HoNrWuL0HhdmOp8dGzORWuhLKqgdlrfWDuXEri
         eN996RR2IPvKx0g26NQdmdPLm7TOSaRO9dIs9PgP+7PynwrZar5nKXPfyEuCklCuCmMR
         Za36cXZ1XOlr/N2YqXU6aPo7xRXTYV87ZQMA2uY+c53XdH8tr419tcBvPsprF3ofT6W4
         N0Mw==
X-Received: by 10.50.56.82 with SMTP id y18mr80424668igp.25.1425969629034;
 Mon, 09 Mar 2015 23:40:29 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Mon, 9 Mar 2015 23:39:58 -0700 (PDT)
In-Reply-To: <CAPig+cSCTJH-otgWAQxwjwkw0SbP4OFXyDhUZs=0bzoL7B32ig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265212>

On Tue, Mar 10, 2015 at 1:23 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> +static int add_directory(struct string_list *result,
>> +                        const char *name)
>> +{
>> +       struct strbuf sb = STRBUF_INIT;
>> +       const char *p;
>> +
>> +       strbuf_add(&sb, name, strlen(name));
>
> strbuf_addstr() perhaps?

Yeah. The previous version of this function takes string length as an
argument, but then I dropped that and used strlen() instead. Thanks
for catching.
-- 
Duy
