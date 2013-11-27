From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 06/28] connect.c: teach get_remote_heads to parse
 "shallow" lines
Date: Wed, 27 Nov 2013 20:02:14 +0700
Message-ID: <CACsJy8CwbNuOVuQ7nBjXuosX-5MCo_u1pFUHqLXzBa9hd7M8Vg@mail.gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1385351754-9954-7-git-send-email-pclouds@gmail.com> <xmqqtxf0w440.fsf@gitster.dls.corp.google.com>
 <xmqqd2low1b5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 27 14:03:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vleli-0008Jv-Vj
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 14:03:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995Ab3K0NCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 08:02:45 -0500
Received: from mail-qa0-f44.google.com ([209.85.216.44]:55305 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835Ab3K0NCp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 08:02:45 -0500
Received: by mail-qa0-f44.google.com with SMTP id i13so5718003qae.3
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 05:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1a0UoOYdNfD7waYpXQvqMHtR/yfiyO+0LpnDloOUJIE=;
        b=QqeAmA2I+CjZG7PXgbQYM1juoV6T+qewz79H46k96hFy+6WSV+sS8dl9XIndxNU2ex
         zk0qTmY+6LDRooyLln7Csc49EXeLx5/xKIEnK1xXYx9OPr79/hoFQiGlQbOWpYKt6MK+
         gyOifbECZS8I+waBUF2l4DCc5jlWfWtcYMT8HzuT0uA9aeAbgNcRCC+tQNqFXXmt2jKE
         zJYYWFWezqDrV9OlZfqGkhDVB0x2zLU/0A/qKu0/l07tFVLZpi6olVpVUgbGwgtvjsSg
         h44uwG9IenCpXV5qvjpMh9OLuIsQkjwM/2yvrOPeI+AdqBxfgj/8yZNkiQl0Yt6z9yLK
         JX8A==
X-Received: by 10.49.1.230 with SMTP id 6mr66671604qep.48.1385557364340; Wed,
 27 Nov 2013 05:02:44 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Wed, 27 Nov 2013 05:02:14 -0800 (PST)
In-Reply-To: <xmqqd2low1b5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238440>

On Tue, Nov 26, 2013 at 5:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Perhaps a preparatory patch needs to rename the structure type to
>> object_name_list or something.  And then we can make the variable
>> names, not typenames, responsible for signalling what they mean,
>> i.e.
>>
>>       get_remote_heads(...
>>               struct list_of_objects *extra_have,
>>                 struct list_of_objects *shallow_points);
>>
>> when we introduce the new parameter.
>
> Yuck, and these are not "list-of-objects", either.  They are
> "list-of-object-names".

I was thinking of renaming it to sha1_array and what do you know, we
do have 'struct sha1_array' with exact same (or better) functionality
that extra_have_objects provides. Will replace extra_have_objects with
current sha1_array.
-- 
Duy
