From: =?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@gmail.com>
Subject: [stgit] Documentation build error in proposed branch
Date: Mon, 8 Feb 2010 14:00:03 +0100
Message-ID: <a1e915351002080500u74e4878fy500713ddb25aa750@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 14:00:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeTDq-0003Qx-0J
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 14:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555Ab0BHNAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 08:00:06 -0500
Received: from mail-bw0-f223.google.com ([209.85.218.223]:33698 "EHLO
	mail-bw0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab0BHNAF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 08:00:05 -0500
Received: by bwz23 with SMTP id 23so1064390bwz.1
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 05:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=Uq0BwZwXdUARR1/3H1tX0dAi7okixynABAu3eLMKkD4=;
        b=ZmdlxEVg0jU8jQ0DRatkvIcoP+YIYKMkz0zH+DakB6gzFFIdziVsxaYNMULBTUpU9N
         EBUiBLdEGT37o9PLY1K5FOh2dcb6edSlUYaUPHSVLQ6XhZt4peqAAC8MWF8/en3a3jFL
         D/+zAwPAdNkfB3GHU+2qBcLZ7VtCxjC7Dxlpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=hums74a66rvDDbpfO1vbeGopRbhEeRYVw4RFF472lXpLjTsVSw0YcAZfECY0GsbV9u
         66iuHQ1IxNCOhWBr0db0E5f1iOf/IDwSOaLK6gY/aGIUfL1hdajj8kNomnpfLlXYGSXv
         UtT+jlEfmReOA1yzOilM16rZR0q/TIu/uKFHg=
Received: by 10.204.128.82 with SMTP id j18mr1265141bks.133.1265634003772; 
	Mon, 08 Feb 2010 05:00:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139288>

As of recently, I cannot compile documentation in
git://repo.or.cz/stgit.git proposed:

lux:~/devel/stgit$ git ls-files -o | xargs rm
lux:~/devel/stgit$ git rev-parse HEAD
c7506039d0299c093140857b7a617ec6bcdbfc13
lux:~/devel/stgit$ make all doc
   :
cd Documentation && make all
make[1]: Entering directory `/home/gustav/devel/stgit/Documentation'
rm -f doc.dep+ doc.dep
perl ./build-docdep.perl >doc.dep+
mv doc.dep+ doc.dep
make[1]: Leaving directory `/home/gustav/devel/stgit/Documentation'
make[1]: Entering directory `/home/gustav/devel/stgit/Documentation'
../stg-build --cmd-list > command-list.txt
Traceback (most recent call last):
  File "../stg-build", line 41, in <module>
    main()
  File "../stg-build", line 31, in main
    commands.get_commands(allow_cached = False), sys.stdout)
  File "/home/gustav/devel/stgit/stgit/commands/__init__.py", line 89,
in asciidoc_command_list
    for kind, cmds in _command_list(commands):
  File "/home/gustav/devel/stgit/stgit/commands/__init__.py", line 72,
in _command_list
    yield kind, sorted(kinds[kind].iteritems())
KeyError: 'Alias commands'
make[1]: *** [command-list.txt] Error 1
make[1]: Leaving directory `/home/gustav/devel/stgit/Documentation'
make: *** [doc] Error 2

- Gustav
