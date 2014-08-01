From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Cross compiling git for ARM
Date: Fri, 1 Aug 2014 12:53:59 -0500
Message-ID: <CAHd499BjTqurQX4Lj6MUqzKQW8Qsf-2UDVe6G4qiZW3anEzuVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 19:54:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDH1q-0007xQ-AG
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 19:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205AbaHARyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 13:54:01 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:46202 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbaHARyA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 13:54:00 -0400
Received: by mail-vc0-f174.google.com with SMTP id la4so7171831vcb.5
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 10:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=fz8Bo5aIuvvWQW8Hb00NZm/w63ATCNRjt6m2P0ouSdQ=;
        b=khw+jtmLeafiUkyHWECOkT0hYh1z0gqWkmyj/I9vETQ8FDsD35Krs/Jctv10WjVkNy
         TjiBFkFXkrTXxah0YnSpw4TgoudUjINTN8f5LQhBh+CMJ61RN8Ti+Bi31cYyDnIRL5uQ
         cCoY3aeB0xyinSkRJsgIWhFsL329Blya5ZvFtxdKaSfdMnmuEsvMchacyl1LYI+Zhvlv
         4rhhco4KiJSNTlIaXEw+H8SF0ZhDUc0xveVA2YReAqlhQNwBE3HKDYOPBFfmrs3eJ6CA
         bgFlyvMhYSIVHNTjyDd5vjSS67P4MFevTky0/tJmpm4IKmMyjeDxZ5dLihsMCoplFFsS
         eI1Q==
X-Received: by 10.52.69.172 with SMTP id f12mr7254401vdu.9.1406915639720; Fri,
 01 Aug 2014 10:53:59 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.102.201 with HTTP; Fri, 1 Aug 2014 10:53:59 -0700 (PDT)
X-Google-Sender-Auth: hIR13rBUlnVO8Z_bwmV7y5SmsCs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254644>

Hello,

I'm interested in cross compiling Git 2.0.3 (I have a clone from
github) for ARM. Ideally I'd like to use the prebuilt gcc eabi
toolchain bundled with Android NDK, since I plan to run the git
executable on an ARM device running the android kernel.

I've looked into the "./configure --help" documentation but nothing
strikes me as helpful for this. I also have relied heavily on Google
searching but again I'm hitting dead ends.

I'm not an expert with Linux, so it would really help to have a set of
instructions that are detailed and easy to understand.

Here is as far as I've gotten:

1. Ran "autoconf" inside my git clone root.
2. Ran "./configure --prefix=/home/fe/git-arm --build=x86_64-linux-gnu
--host=arm-linux-gnueabi"
3. Ran "make"
4. Build fails because there is no OpenSSL.

Then I began to wonder, do I need to cross compile OpenSSL, ZLib, and
other things too? This is getting pretty messy :(

Note that on step #2 I am using the gcc arm cross compiler from Ubuntu
package manager, because I couldn't for the life of me get the Android
NDK toolchain working. I'm fine with using the ubuntu one as long as
it yields an ARM executable that can be run on my device.

Our device is ARM Cortex - A8, so I'm not sure what version of GCC ARM
is compatible with this chip.

Thanks in advance for any help at all!!
