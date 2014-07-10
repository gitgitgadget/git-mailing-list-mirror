From: David Turner <dturner@twopensource.com>
Subject: Re: 745224e0 gcc-4.9 emmintrin.h build error
Date: Thu, 10 Jul 2014 13:53:36 -0700
Organization: Twitter
Message-ID: <1405025616.3775.6.camel@stross>
References: <CAOvwQ4hNVvzeCUczi7Qurcycp8HA8KU=u1ntu3fzBwu4fTEzPQ@mail.gmail.com>
	 <1405024438.3775.3.camel@stross>
	 <CAOvwQ4hq5AZ0ZhB-1etUZfLfJ4X=11_03syH2pgY_fi=FSLAPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 22:53:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5LLd-0005KL-5h
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 22:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbaGJUxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 16:53:41 -0400
Received: from mail-qa0-f54.google.com ([209.85.216.54]:47110 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbaGJUxk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 16:53:40 -0400
Received: by mail-qa0-f54.google.com with SMTP id s7so128599qap.27
        for <git@vger.kernel.org>; Thu, 10 Jul 2014 13:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=vn/EjAZAYkrkkr6f+btThSV0etHrIsn7uERbgHcAYd4=;
        b=UkBYFBl4hrEGEeXOYcA8RbDWGKbJ6RqUHaU80pPJvt8Ne6dtM44w0biDR52Kiy2nNT
         1HJuSMozld3SJeX4yl344GiR++1n22tPckcAyokI6NjRlDkQmAhTwIsRrLwgEORFv9wi
         UrwYMz9DO8pvSdDXSwS7L7AE1rqLXqjI02/tVAwYG+0tNTxplg14hfqY/aW9pgo7/Y4k
         +DGDSB6NadnznVysH7mz8sIsgAUptG75HL6W8m2gjMymWi5dskpje43AwdDk70MbLcQi
         b8sXNfYLzhlzxX+LuNZRvlGM52Pjd+dpsivBVSBxHl9/brpuCn3DNNpQsCDOEUWDkz06
         2oAg==
X-Gm-Message-State: ALoCoQmTQ7NfArtDgXSqsQkZz3NSnkSWTx11Lad8M+rd4HaMXyEdwgaKHdss2jfZkWW+BqMD0zjb
X-Received: by 10.224.151.72 with SMTP id b8mr19821846qaw.95.1405025619653;
        Thu, 10 Jul 2014 13:53:39 -0700 (PDT)
Received: from [172.25.140.220] ([8.25.197.27])
        by mx.google.com with ESMTPSA id d10sm489894qaq.10.2014.07.10.13.53.38
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 10 Jul 2014 13:53:38 -0700 (PDT)
In-Reply-To: <CAOvwQ4hq5AZ0ZhB-1etUZfLfJ4X=11_03syH2pgY_fi=FSLAPQ@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253218>

On Thu, 2014-07-10 at 22:44 +0200, Tuncer Ayaz wrote:
> On Thu, Jul 10, 2014 at 10:33 PM, David Turner wrote:
> > On Thu, 2014-07-10 at 21:59 +0200, Tuncer Ayaz wrote:
> > > The changes in 745224e0 don't seem to build here with gcc-4.9 on
> > > linux x64_64. Any idea what's wrong?
> > >
> > >     CC credential-store.o
> > > In file included from /usr/lib/.../xmmintrin.h:31:0,
> >
> > What's in the ...?
> >
> > Because if you're using headers from a different version of gcc, that
> > might explain it.
> 
> /usr/lib/gcc/x86_64-unknown-linux-gnu/4.9.0/include/emmintrin.h

That seems fine to me.

It looks like the error messages are coming from inside the system's
header files (but this is sometimes misleading).  If you just try to
compile

#include <emmintrin.h>
int main() { }

with whatever options you use for git, does that work?  If not, I would
say that you have a compiler setup problem.
