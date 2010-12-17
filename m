From: Justin Pitts <justinpitts@gmail.com>
Subject: unable to resume git svn fetch
Date: Fri, 17 Dec 2010 09:28:15 -0500
Message-ID: <62DF67FC-1C4E-4E65-9B19-B485CDF5EEF6@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 17 15:28:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTbII-00083j-7U
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 15:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046Ab0LQO2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Dec 2010 09:28:20 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58730 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754905Ab0LQO2T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Dec 2010 09:28:19 -0500
Received: by qwa26 with SMTP id 26so739759qwa.19
        for <git@vger.kernel.org>; Fri, 17 Dec 2010 06:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:content-type
         :content-transfer-encoding:subject:date:message-id:to:mime-version
         :x-mailer;
        bh=yNpdd+vpdykOU7vmg0HrsDC3jqWuFn7s16FJZuZYhkA=;
        b=TxbwjcOBSNuUbZkQxWk0NT0gyiB0jc7pw6MZsySVKameO9L3anoIu9TpjW1tHaTtRM
         7ePfLeTmlJbkrIUcHQ3kEWXRle66sLW0EmL9AmQiRd4OdFFXRteNj87WluBPIW9RwCPx
         ckye/8LraimHawY4Qn/sQ9dnSXcZaBudGQLzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        b=LhIfMmIsD0Yy7mhAyZGhexUzq9AvxvXwe7jyweHEzOwWwOHStWFOeOpc5URJl9gVOj
         e/3vicc/P44Y8gi+9zugU6Xhn4Ai2c07ArSfl9YaO409j0iTGDsVAkeuQFrx8JmmG8JC
         OwIrT9jRIBxG0VUXyCnkzjUkY49esnMWPCFjA=
Received: by 10.224.54.65 with SMTP id p1mr866315qag.241.1292596098114;
        Fri, 17 Dec 2010 06:28:18 -0800 (PST)
Received: from h164.cmh.bplglobal.net (rrcs-74-219-149-162.central.biz.rr.com [74.219.149.162])
        by mx.google.com with ESMTPS id g32sm179487qck.10.2010.12.17.06.28.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Dec 2010 06:28:17 -0800 (PST)
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163881>

Hello,

I am trying to import a SVN repo that I will be tracking for the foreseeable future.
The clone command was
git svn clone -T trunk -t tags -t release_tags -b branches -b private/branches $REPO

The fetch has been interrupted several times. Up until now I have had no problem resuming with git svn fetch.

Now, fetch fails on r9007 with 
	Incomplete data: Delta source ended unexpectedly at /opt/local/libexec/git-core/git-svn line 5117

I see some messages on the BUG mailing list regarding this error, but I get somewhat lost in the details of the repair and trying to understand how I might apply them to my scenario. Also, 

git svn log
and
git svn reset -r9006
fail with
	fatal: ambiguous argument 'HEAD': unknown revision or path not in the working tree.

More detail from my shell session is at https://gist.github.com/79e08fe7551875f8bce9

This is git v1.7.3.3 on OSX v1.6.5 via MacPorts. I see that 1.7.3.4 is out, though not in MacPorts yet and nothing in the 
release notes lead me to believe it would be useful, though I am certainly willing to do a source install if it is.

It was suggested in #git that I ought to limit the amount of history I am importing. I think that's a cop-out, but I'll listen to a reasoned argument why that opinion is wrong.

Thanks in advance,

Justin