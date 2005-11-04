From: Morten Welinder <mwelinder@gmail.com>
Subject: CFLAGS usage
Date: Fri, 4 Nov 2005 10:21:55 -0500
Message-ID: <118833cc0511040721w7f3990fbw631feaa6a4bda936@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Nov 04 16:24:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY3OC-0008FZ-TC
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 16:22:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbVKDPV5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 10:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbVKDPV5
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 10:21:57 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:19117 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964920AbVKDPV4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 4 Nov 2005 10:21:56 -0500
Received: by zproxy.gmail.com with SMTP id 13so270557nzn
        for <git@vger.kernel.org>; Fri, 04 Nov 2005 07:21:55 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hiLa/t8ymlpuJeCspFkFr8djT8gAZis0MnUczxIDWH+2Z9/R5IMw5Kjy1SvJCj+6PFwBlzWqt4TrzdytStk0pbrc+KdiN/qt5mxodLPADordFOFx2A1fmWTd1TZPR0iuuINC7y3OP0K7xzd8V5wzCNtq9O/L5xwXCdLzpWG8xr8=
Received: by 10.65.158.14 with SMTP id k14mr2170748qbo;
        Fri, 04 Nov 2005 07:21:55 -0800 (PST)
Received: by 10.65.107.12 with HTTP; Fri, 4 Nov 2005 07:21:55 -0800 (PST)
To: GIT Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11134>

Various stuff is being added to CFLAGS, but CFLAGS is not being used
after being composed in CFLAGS_ALL.

Morten



grep CFLAGS Makefile
CFLAGS = -g -O2 -Wall
ALL_CFLAGS = $(CFLAGS) $(PLATFORM_DEFINES) $(DEFINES)
                CFLAGS += -I$(CURLDIR)/include
                CFLAGS += -I$(OPENSSLDIR)/include
                CFLAGS += -I$(ICONVDIR)/include
        $(CC) -o $*.o -c $(ALL_CFLAGS) $<
        $(CC) -o $*.o -c $(ALL_CFLAGS) $<
        $(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
        $(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^) $(LIB_FILE) $(SIMPLE_LIB)
        $(CC) -c $(ALL_CFLAGS) \
        $(CC) $(ALL_CFLAGS) -o $@ test-date.c date.o ctype.o
        $(CC) $(ALL_CFLAGS) -o $@ $^
        for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i; done
