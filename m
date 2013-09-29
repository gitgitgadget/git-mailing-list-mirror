From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 13/44] ruby: bind setup_git_directory()
Date: Sun, 29 Sep 2013 10:41:47 +0530
Message-ID: <CALkWK0kSWDiKHDNcFFXHMa__YZXpL=YAL_zejvTRu7bAqUc6Vw@mail.gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com> <1380405849-13000-14-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 29 07:12:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ9J2-0006Cn-4S
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 07:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218Ab3I2FM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 01:12:28 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:39997 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab3I2FM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 01:12:27 -0400
Received: by mail-ie0-f175.google.com with SMTP id e14so7254611iej.20
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 22:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+q3Y3JgZypDH1v1kFzHVIZ3F+DQKWxaONOZWCsf5V7A=;
        b=Rr3olOHkVZvoYGaQIhy4wc+rcg41bvSaK90Ta3KeK7b9KDoK+nz/3TGHR0p9NfZI9d
         IyrEKPqmNwMAd8WoSR5s9ZL7+6IU7aadTCeHceoIRUgfuFH0p9APRHpuh2n51O22lmFm
         oA4vFyTeScjQgj3aKqQy5kU1wrz6cvaHQjQDvCFfU0TU5rUussooAU5NQA1KJwUDlfxz
         OqHcditRPjNCngbAKk78uQj9IM+5pNoqd69I/g7zkBmFz4+wc7232rlkNsGxedxySbFq
         P/pZDhexWwsmZ+gwRMziYZUwfisccV5+GTlGDjeDx2Gq7qdiuNLYJpqn0KUf9YfQd6/+
         Tuyw==
X-Received: by 10.50.23.16 with SMTP id i16mr8754935igf.50.1380431547360; Sat,
 28 Sep 2013 22:12:27 -0700 (PDT)
Received: by 10.64.73.36 with HTTP; Sat, 28 Sep 2013 22:11:47 -0700 (PDT)
In-Reply-To: <1380405849-13000-14-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235589>

Felipe Contreras wrote:
> +static inline VALUE cstr_to_str(const char *str)
> +{
> +       if (str == NULL)
> +               return Qnil;
> +       return rb_str_new2(str);
> +}
> +
> +static VALUE git_rb_setup_git_directory(VALUE self)
> +{
> +       int nongit_ok;
> +       const char *prefix;
> +       prefix = setup_git_directory_gently(&nongit_ok);
> +       return rb_ary_new3(2, cstr_to_str(prefix), INT2FIX(nongit_ok));
> +}

Most excellent. Goes to show how well ruby.h is written.

I'm not very familiar with the interface, and am referring to
http://www.ruby-doc.org/docs/ProgrammingRuby/html/ext_ruby.html -- let
me know if there are some other sources.
