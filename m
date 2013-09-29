From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 14/44] ruby: bind dwim_ref()
Date: Sun, 29 Sep 2013 00:24:02 -0500
Message-ID: <CAMP44s2Kd0xUXfRQ07qJ1yvXiUkOmXCMA67wrk4Vg9oN8TRMGQ@mail.gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
	<1380405849-13000-15-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mutBpqvu31uZARUFtGzN6zwP4A=915u=xBoc+PXQp+_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 29 07:24:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ9UG-0007ry-U8
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 07:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323Ab3I2FYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 01:24:05 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:41307 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab3I2FYE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 01:24:04 -0400
Received: by mail-la0-f44.google.com with SMTP id eo20so3417788lab.31
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 22:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=K/GyVivbl4pzrN14Nag1Ns5w4nTmJAq5QqtJ+LOd1f4=;
        b=oQi5LrmYobKMWz34VdoE8hSzfuInze+c2X+PlQGjxCo34MRDdaXY90nLY2x51AmrkC
         SotrVrUJhx6toGJTMFDk3OUY4fzATS20dlH0/z8zZB2yX00PZCC/M2GxrbQK/RK5WGYi
         Hle89wSD3hdcP3P0+lVuT7ZdU5P/2idGyySxkS8I2rw1KE7jru8kuSYUsNKz2kFOk0fp
         HqY1y5rm4ViohXsU2xhdrYptgVdcx+iwDh1FpLOToboWZ9ginGhKzD5xuGrYDv/hfgSQ
         6bA20tN6znAx4hvKP5d6N1Py2dIkU8Fhnh2xgOkQO1nk4SS5vvXXBRkmO5yrFSr5Qx3j
         lvmQ==
X-Received: by 10.152.36.98 with SMTP id p2mr13598641laj.14.1380432242285;
 Sat, 28 Sep 2013 22:24:02 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Sat, 28 Sep 2013 22:24:02 -0700 (PDT)
In-Reply-To: <CALkWK0mutBpqvu31uZARUFtGzN6zwP4A=915u=xBoc+PXQp+_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235591>

On Sun, Sep 29, 2013 at 12:17 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>>  static void git_ruby_init(void)
>>  {
>>         rb_define_global_function("setup_git_directory", git_rb_setup_git_directory, 0);
>>         rb_define_global_function("for_each_ref", git_rb_for_each_ref, 0);
>> +       rb_define_global_function("dwim_ref", git_rb_dwim_ref, 1);
>>  }
>
> At this point, global functions is probably the way to go. We might
> like to put them in classes to create a beautiful Rugged-inspired API
> in the future.

We might, for certain things, but as I explained before, we can't
really do the same.

test1 = Rugged::Repository.new("test1")
test2 = Rugged::Repository.new("test2")

How are we supposed to do this with Git's code? If Git's code can only
work with one repository at a time, I think the Ruby bindings should
reflect that as well.

-- 
Felipe Contreras
