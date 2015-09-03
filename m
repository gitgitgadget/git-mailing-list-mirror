From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v15 07/13] ref-filter: add support for %(contents:lines=X)
Date: Thu, 3 Sep 2015 19:19:03 +0530
Message-ID: <CAOLa=ZRSbixzcNyF_s2E+oHMJsG7SuKizb5WHHk5Dmj-OKEetw@mail.gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
 <1441131994-13508-8-git-send-email-Karthik.188@gmail.com> <vpq8u8ptcjq.fsf@anie.imag.fr>
 <CAOLa=ZTB_uMvKjU=f9UgmvOmeZD4YtFL_Gv1+VvZAgDV-6WYDA@mail.gmail.com>
 <vpq7fo8ol7i.fsf@anie.imag.fr> <CAOLa=ZRiGg1snfsi_mxQYq-wV6Zz4cTkxum47dRowp1XopQejw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 03 15:49:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXUtW-00028h-1N
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 15:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683AbbICNte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 09:49:34 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:32889 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755674AbbICNtd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 09:49:33 -0400
Received: by obbbh8 with SMTP id bh8so32669065obb.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 06:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mNBBOHblvle5Kgvfb6Bsqn1qlcFEtGDfkiOtGZdlH1Q=;
        b=urbsWExZJakCUtMBGNOhEFgXqlKQGkV14P3jGMO4SENdLKs7L4AzhiOjUtzRRDROT2
         QwqSdkT5C2t8hcUaqJ06blJ9YV8vtiR3qjQlvtN7lZHLH+OT9I921SXSDMOSnhnnnVqa
         1bNoNxvQIzgjgju0UPxW1Ucl+J4XDZM3vPe8Ki5STJYh8PGnt6n5Xp19Hvj1jFG3fdCO
         J1h/SahYzNggS+a4iuA0zp5Bg6Q6X3G1kGsHY41vVqrJSP52iRpLM1Rw/vCeBgqLgHI2
         7zeRf0VeKISwucSVjFLOZlYYZ9l0j9BchGVx3lFeHUvEdwC8YxUNCv1r40UNHVCjTnRY
         dVhg==
X-Received: by 10.182.153.161 with SMTP id vh1mr25473718obb.34.1441288172818;
 Thu, 03 Sep 2015 06:49:32 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Thu, 3 Sep 2015 06:49:03 -0700 (PDT)
In-Reply-To: <CAOLa=ZRiGg1snfsi_mxQYq-wV6Zz4cTkxum47dRowp1XopQejw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277203>

On Thu, Sep 3, 2015 at 7:04 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>                         struct strbuf s = STRBUF_INIT;
>>                         if (strtoul_ui(valp, 10, &v->u.contents.lines))
>>                                 die(_("positive width expected contents:lines=%s"), valp);
>> -                       append_lines(&s, subpos, sublen + bodylen - siglen, v->u.contents.lines);
>> +                       append_lines(&s, subpos, bodypos + bodylen - subpos, v->u.contents.lines);
>>                         v->s = strbuf_detach(&s, NULL);
>>                 }
>>         }

append_lines(&s, subpos, bodylen + bodypos - subpos - siglen,
v->u.contents.lines);

We need to eliminate the signature if existing also.

-- 
Regards,
Karthik Nayak
