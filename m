From: Yiyi Sun <yiyisun@gmail.com>
Subject: Fwd: git-receive-pack --stateless-rpc
Date: Thu, 17 Jun 2010 09:45:07 -0400
Message-ID: <AANLkTikbUp7_22alAbgNFO30R7vkPUAOr7qvJ6a86Zc7@mail.gmail.com>
References: <AANLkTikwu4iKnG-DzclRPFNF7djNKZ31xR82aO0ryVJ3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 17 15:45:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPFPC-00019E-U0
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 15:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760054Ab0FQNpK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jun 2010 09:45:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56198 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759992Ab0FQNpI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jun 2010 09:45:08 -0400
Received: by fxm10 with SMTP id 10so1604541fxm.19
        for <git@vger.kernel.org>; Thu, 17 Jun 2010 06:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=Wq0PyYoDKVGLpEYlFLT/bVDT24KG9QPRCFOIc/2vueo=;
        b=ns34SeqWGozn8XEkR/pP7BVSTH8yCeZ5g7/l36s7wdseC+Lukr93gQnUO5t1xYicV9
         +MJJD+UO2ulq43WZsfoIfdfaCt0r5mjA5kFSZGXB1vt61JrLbKZtBh31lcLqVGww/47i
         6so4LqY4hd4xi69y6f0kn9WVdkP3p4zHg8UsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=YDy7kX5xLASzfcFStuQ0BMoRwxmsLEUsAXB2RgdVtuyTuJkIvhyQZGxmmh2VVo6LLA
         AuY1WgXKSUisvYIhV+Ng9KB8PLkkmzvv9bTeRwE/Cp0hMVEUiL0cihxv/UIM4nMjsVGl
         LTIO1Pr144/RUr+WDWqjYf78E2vGUZKY0WKic=
Received: by 10.239.187.66 with SMTP id k2mr628351hbh.84.1276782307311; Thu, 
	17 Jun 2010 06:45:07 -0700 (PDT)
Received: by 10.239.153.134 with HTTP; Thu, 17 Jun 2010 06:45:07 -0700 (PDT)
In-Reply-To: <AANLkTikwu4iKnG-DzclRPFNF7djNKZ31xR82aO0ryVJ3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149307>

Hi,

I am creating a Git smart HTTP protocol wrapper and run into two
problem. I tried the msysGit mailing list and was told to ask them to
the main git mailing list.

Here is the story. During 'git push',=A0 I successfully processed the
initial GET request of '/info/refs?service=3Dgit-receive-pack' by
sending back the output of 'git receive-pack --stateless-rpc
--advertise-refs'. Then msysGit did a the POST request. I
invoked 'git receive-pack --stateless-rpc', which returned:

0030 000eunpack ok
0019ok refs/heads/master
00000000

Question #1,=A0Is the result supposed to be something below instead?

000eunpack ok
0019ok refs/heads/master
0000

Question #2, msysGit cannot parse the result, it displays error message=
:

fatal: protocol error: bad line length character:
003
fatal: The remote end hung up unexpectedly

It seems that msysGit can read the http response of HTTP GET, but not
of HTTP POST.


Can you please help ?

Thanks,

yysun
