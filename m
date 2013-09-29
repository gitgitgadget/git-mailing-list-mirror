From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 13/44] ruby: bind setup_git_directory()
Date: Sun, 29 Sep 2013 00:40:34 -0500
Message-ID: <CAMP44s2GFVxRgnR3ReM4mknpC5DXUZMBPgK+JoyOQwX0padsDg@mail.gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
	<1380405849-13000-14-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0kSWDiKHDNcFFXHMa__YZXpL=YAL_zejvTRu7bAqUc6Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 29 07:40:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ9kG-0005IC-I9
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 07:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385Ab3I2Fkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 01:40:37 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:45792 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab3I2Fkg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 01:40:36 -0400
Received: by mail-lb0-f174.google.com with SMTP id w6so3437663lbh.19
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 22:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4hqnV8Y3AhBVcqtUXCj6mWDKCzcTveWqUh7Y4mk82IM=;
        b=aOGbknie3Alnd4U1EA0X3LREjVoTK/Rfi3iUM22Pn62GnIadZmbamkt4j/U/iIrmLm
         PTHqfhEX2UuBvVUWpJUWts5i0oYUNJYvGk9KND5V4YKcGUVItI3BkWipk/cKVVrzKUaF
         hGohy34qriv7EAp282qrOeR6ai8fnmPC6Zyad4DYg5DWMawFTgdG1u5iISqUzbfWb5JZ
         1F2gg9D1O/D9nzDGHRu/OchPjGwtw6Z/s65EwcDQKiR7XHh3EHlFbJp5RpFSVIKu0mkp
         ZyYmaJTNsf5KZJxm4GdgG4+m0PrRQw7a22SVyghU6Ml8YAfYJNaSYcsCgsq/51OxgB1r
         vXLA==
X-Received: by 10.112.126.37 with SMTP id mv5mr16277076lbb.20.1380433234462;
 Sat, 28 Sep 2013 22:40:34 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Sat, 28 Sep 2013 22:40:34 -0700 (PDT)
In-Reply-To: <CALkWK0kSWDiKHDNcFFXHMa__YZXpL=YAL_zejvTRu7bAqUc6Vw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235592>

On Sun, Sep 29, 2013 at 12:11 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> +static inline VALUE cstr_to_str(const char *str)
>> +{
>> +       if (str == NULL)
>> +               return Qnil;
>> +       return rb_str_new2(str);
>> +}
>> +
>> +static VALUE git_rb_setup_git_directory(VALUE self)
>> +{
>> +       int nongit_ok;
>> +       const char *prefix;
>> +       prefix = setup_git_directory_gently(&nongit_ok);
>> +       return rb_ary_new3(2, cstr_to_str(prefix), INT2FIX(nongit_ok));
>> +}
>
> Most excellent. Goes to show how well ruby.h is written.

Indeed. I find it easier than using GLib.

> I'm not very familiar with the interface, and am referring to
> http://www.ruby-doc.org/docs/ProgrammingRuby/html/ext_ruby.html -- let
> me know if there are some other sources.

That one is really good and got me almost as far as I am.

Others might give a bit more information, but nothing too critical.

http://stackoverflow.com/tags/ruby-c-api/info

-- 
Felipe Contreras
