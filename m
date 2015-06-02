From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFCv2 01/16] stringlist: add from_space_separated_string
Date: Tue, 2 Jun 2015 16:42:04 +0700
Message-ID: <CACsJy8BEEvgP_YzVnbPaLL9QBs48sd2fn6CeicXD_9U92=9UnA@mail.gmail.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com> <1433203338-27493-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 11:42:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yziib-0005G4-II
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 11:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbbFBJmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 05:42:37 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33699 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940AbbFBJmf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 05:42:35 -0400
Received: by igbpi8 with SMTP id pi8so81689305igb.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 02:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zhFMWhqgYIlmQA3i/Zl9UY0tnbgdIYGxqFI4hH/KAfI=;
        b=PUJR0O5b586iWy01owowlRfBwlPu+7INPMWfhmgDmsooHjwmJzUvBWyWZbXr0wi2lw
         iteZHtqoA0i5cAlcnuzP5FvscnNaBN6WP16sJr5942SSDkn7onljP/VfIjkGK2HunWD2
         8qhI9mtODfae3g/9TsfT9WoVGFevGDVS+FHh5FafJcxtH2Hv731EQ+My4qIx//ZPnkU2
         w9Ih7QcJ3mrQwp7qEXjq2mdEaYtngYEdoe/cnkjMjliTmPJAKrDw6M2ul/gTUTmFixj6
         6oL7dowuiq+YQ2P4Y8pWUdkUtbiochqi4VuZbGvGVflw9TUykEKA+DBDIEMp7UN1XKQ4
         SPuQ==
X-Received: by 10.43.172.68 with SMTP id nx4mr4657754icc.48.1433238154774;
 Tue, 02 Jun 2015 02:42:34 -0700 (PDT)
Received: by 10.107.6.9 with HTTP; Tue, 2 Jun 2015 02:42:04 -0700 (PDT)
In-Reply-To: <1433203338-27493-2-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270511>

On Tue, Jun 2, 2015 at 7:02 AM, Stefan Beller <sbeller@google.com> wrote:
> diff --git a/string-list.h b/string-list.h
> index d3809a1..88c18e9 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -19,6 +19,7 @@ struct string_list {
>  #define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1, NULL }
>
>  void string_list_init(struct string_list *list, int strdup_strings);
> +void from_space_separated_string(struct string_list *list, char *line);

The name feels out of place. All functions in here have "string_list"
somewhere in their names. The implementation looks very close to
string_list_split() but that name's already taken.. Maybe
string_list_split_by_space()?
-- 
Duy
