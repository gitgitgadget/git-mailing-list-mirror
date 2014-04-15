From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 1/2] Makefile: use curl-config to determine curl flags
Date: Tue, 15 Apr 2014 06:20:52 -0400
Message-ID: <CAD0k6qQJE6a5DmRnpiFpOc_MFjSn9eFyiJ2nFaL63rctvxwt5Q@mail.gmail.com>
References: <1397344502-23459-1-git-send-email-dborowitz@google.com> <xmqqioqboe50.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 12:21:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wa0Uh-0005zu-Uz
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 12:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808AbaDOKVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 06:21:31 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:50414 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbaDOKVN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 06:21:13 -0400
Received: by mail-la0-f46.google.com with SMTP id hr17so6666221lab.19
        for <git@vger.kernel.org>; Tue, 15 Apr 2014 03:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xfpOrYI+AdA3jXQMeueu5vHkZEPSUBq945ASYZG6s5I=;
        b=kMR5Bzv4Y+JfPnAewO+zI5qXs4eL1GvaDAzB40U0So5UE/sN43NUX7Jlc7YrHjjDdu
         sEQ6vMlh0dmFjEneA5VimuJCql0PUEpPTcaQiv2nUoyRf0KFrJTaQF+zw17o2xjfmwxh
         Mz1vEnzBjTYLdCEO6O9y0Ct32TObTKlKV6QcX24+IgeuVEVjvanu3yQf6dG/mpPN+zLp
         v/2CEZACKIxW+o8TUKETlBN6GDN+LJHISx4/cpqpo2lRJB19JXYtk3zKGPkPgpnbvCIb
         SUcg3Zak+2+zdnqdsipFXdwSkMqLf5XMbXqqaR9KdjBx5264b8BvgTQxK1lx+tIXwunN
         RB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=xfpOrYI+AdA3jXQMeueu5vHkZEPSUBq945ASYZG6s5I=;
        b=CkmobmTsJyC6HMDWvAXTPmeSRISmus5My9cijIikCKGZBg0L4/f+JTpX6D+0yl1yE5
         n4vtzF/8N5ouSduOuYxdEE942QEoropFWmzrGLtleQyEM+ulT30ab2FJ8rIMVYRC0yhq
         JyzmCAenI/AycEoscGls6cyO+Q6D8m4tED80jM2pk+vytzdFuTfAazVvoisxK+felC+a
         jvIgg1cPVuvQaDlvl/dV2y9wC8H+4Zw0pPbb1E0fr7ZOYp8CK3TqxyZvy3TFHSoToWRD
         Jw4T1Yv9wQpI0Ii0uD8guE0LH0IcItJbRTHOro6bxzRRxNyTqcGkSv29K2aCZLdIrDuy
         pM0Q==
X-Gm-Message-State: ALoCoQmOWNn7mWF4TChdWsvCYsjouKCcmJq0tIY6kk2vJ0CfuSCImDefE7SwGCs0rklyAlGz//Xh1aa/Ph0mGMh7OhZNguMhFX4Hmr2ce63Gpx8OoPzjpmgLXszkV0lHk0ECxYjpca/YtWeYIcN3Wo4b6wwB/Sv/pnfN295ikumYPW2WGlNp8SvEit0PPRrkJs3rbiCW6UQQ
X-Received: by 10.112.142.68 with SMTP id ru4mr611696lbb.49.1397557272347;
 Tue, 15 Apr 2014 03:21:12 -0700 (PDT)
Received: by 10.112.184.227 with HTTP; Tue, 15 Apr 2014 03:20:52 -0700 (PDT)
In-Reply-To: <xmqqioqboe50.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246280>

On Mon, Apr 14, 2014 at 4:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dave Borowitz <dborowitz@google.com> writes:
>
>> curl-config should always be installed alongside a curl distribution,
>> and its purpose is to provide flags for building against libcurl, so
>> use it instead of guessing flags and dependent libraries.
>>
>> Allow overriding CURL_CONFIG to a custom path to curl-config, to
>> compile against a curl installation other than the first in PATH.
>>
>> Use this only when CURLDIR is not explicitly specified, to continue
>> supporting older builds.
>>
>> Signed-off-by: Dave Borowitz <dborowitz@google.com>
>
> Sounds logically the right thing to do.  Was there a particular
> platform that needed this (i.e. cannot be made to work with the
> existing CURLDIR and "guessing flags and dependeent libraries")
> that may be worth mentioning in the log message?

My end goal is to statically link git on Mac OS X (10.9) against a
newer version of libcurl than ships with the OS. The normal CURLDIR
approach should work with system libcurl:

$ /usr/bin/curl-config --libs
-lcurl

But it gets a bit more complicated with a recent curl version. This
likely has to do with the set of enabled options; I passed flags to
./configure based on the build script "MacOSX-Framework" included in
the curl distribution:
$ ~/d/curl-out-7.36.0/bin/curl-config --libs
-L/Users/dborowitz/d/curl-out-7.36.0/lib -lcurl -lgssapi_krb5 -lresolv
-lldap -lz

And with --static-libs there's just that much more:
$ ~/d/curl-out-7.36.0/bin/curl-config --static-libs
/Users/dborowitz/d/curl-out-7.36.0/lib/libcurl.a
-Wl,-syslibroot,/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk
-arch x86_64 -Wl,-headerpad_max_install_names -framework
CoreFoundation -framework Security -lgssapi_krb5 -lresolv -lldap -lz

So I don't think specifying NEEDS_*_WITH_CURL scales to this use case.

While writing this up I also noticed an issue with the second patch,
namely that `curl-config --static-libs` is empty when curl is not
built for static linking.

I will reroll with a more detailed commit message and a fix to the second patch.

>> ---
>>  Makefile | 35 +++++++++++++++++++++++------------
>>  1 file changed, 23 insertions(+), 12 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 2128ce3..d6330bc 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -34,8 +34,12 @@ all::
>>  # git-http-push are not built, and you cannot use http:// and https://
>>  # transports (neither smart nor dumb).
>>  #
>> +# Define CURL_CONFIG to the path to a curl-config binary other than the
>> +# default 'curl-config'.
>> +#
>>  # Define CURLDIR=/foo/bar if your curl header and library files are in
>> -# /foo/bar/include and /foo/bar/lib directories.
>> +# /foo/bar/include and /foo/bar/lib directories.  This overrides CURL_CONFIG,
>> +# but is less robust.
>>  #
>>  # Define NO_EXPAT if you do not have expat installed.  git-http-push is
>>  # not built, and you cannot push using http:// and https:// transports (dumb).
>> @@ -143,9 +147,11 @@ all::
>>  #
>>  # Define NEEDS_SSL_WITH_CRYPTO if you need -lssl when using -lcrypto (Darwin).
>>  #
>> -# Define NEEDS_SSL_WITH_CURL if you need -lssl with -lcurl (Minix).
>> +# Define NEEDS_SSL_WITH_CURL if you need -lssl with -lcurl (Minix).  Only used
>> +# if CURLDIR is set.
>>  #
>> -# Define NEEDS_IDN_WITH_CURL if you need -lidn when using -lcurl (Minix).
>> +# Define NEEDS_IDN_WITH_CURL if you need -lidn when using -lcurl (Minix).  Only
>> +# used if CURLDIR is set.
>>  #
>>  # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
>>  #
>> @@ -1121,18 +1127,23 @@ else
>>               # Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
>>               BASIC_CFLAGS += -I$(CURLDIR)/include
>>               CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib) -lcurl
>> +             ifdef NEEDS_SSL_WITH_CURL
>> +                     CURL_LIBCURL += -lssl
>> +                     ifdef NEEDS_CRYPTO_WITH_SSL
>> +                             CURL_LIBCURL += -lcrypto
>> +                     endif
>> +             endif
>> +             ifdef NEEDS_IDN_WITH_CURL
>> +                     CURL_LIBCURL += -lidn
>> +             endif
>>       else
>> -             CURL_LIBCURL = -lcurl
>> -     endif
>> -     ifdef NEEDS_SSL_WITH_CURL
>> -             CURL_LIBCURL += -lssl
>> -             ifdef NEEDS_CRYPTO_WITH_SSL
>> -                     CURL_LIBCURL += -lcrypto
>> +             CURL_CONFIG ?= curl-config
>> +             BASIC_CFLAGS += $(shell $(CURL_CONFIG) --cflags)
>> +             CURL_LIBCURL = $(shell $(CURL_CONFIG) --libs)
>> +             ifeq "$(CURL_LIBCURL)" ""
>> +                     $(error curl not detected; try setting CURLDIR)
>>               endif
>>       endif
>> -     ifdef NEEDS_IDN_WITH_CURL
>> -             CURL_LIBCURL += -lidn
>> -     endif
>>
>>       REMOTE_CURL_PRIMARY = git-remote-http$X
>>       REMOTE_CURL_ALIASES = git-remote-https$X git-remote-ftp$X git-remote-ftps$X
