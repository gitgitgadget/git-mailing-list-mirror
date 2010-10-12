From: Chase Brammer <cbrammer@gmail.com>
Subject: Push not writing to standard error
Date: Tue, 12 Oct 2010 13:04:02 -0600
Message-ID: <AANLkTim6j7cXj2-1JnKdNLb8KFJK86F02tzeByDBskEa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 12 21:04:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5k8y-0007ft-Th
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 21:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028Ab0JLTEG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Oct 2010 15:04:06 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41630 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979Ab0JLTEE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 15:04:04 -0400
Received: by wwj40 with SMTP id 40so5459925wwj.1
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 12:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=eElvCWnbNNVwQd9sBPR7HPSW9BnrWEXPYyUXcy+4vG0=;
        b=hoBAsEoVDCOG4XX37i/GmsMglUu6gw7sY6BnW2soOJlUaXpEkcf/QVx1ymRuasqXdj
         Fs10wHQfH82P5tmb6STZtNCqd+wBcrTgilIOgD9ni+WeAxR1i8POchYBUddxuK0yGrrB
         vlbKtll5Xi0QWJp8RfrltVisaoSAFpQGY7n+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=YtEn29UR6GZeAcBaYRJgERp0Z+DR++94+Hg+EkjmZIwM9Fqo4yER67RvBYRdRmo6s/
         Hlim+yDTTNPoxF1q8rnqxykBNN3jrr7hMREEXL64oU6We2onnxUZLwoq+4fp7LZvNdrq
         XLVypRS0XWvpNEUyzKaWWbHRFXwAp7WAaiduQ=
Received: by 10.216.1.6 with SMTP id 6mr7213863wec.24.1286910242829; Tue, 12
 Oct 2010 12:04:02 -0700 (PDT)
Received: by 10.216.29.195 with HTTP; Tue, 12 Oct 2010 12:04:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158868>

=46irst time on the mailing list, but I enjoy the IRC channel. =A0Excus=
e
me if this is a logged bug, or if there is a known workaround.

When using git outside of bash, or saving the standard error from bash
to a file during a push doesn't seem to be working. =A0I am only able t=
o
get standard output, which doesn't give the progress of the push
(counting, delta, compressing, and writing status). =A0This does howeve=
r
work just fine with git fetch. For example:

git fetch origin master --progress > /fetch_error_ouput.txt 2>&1

Works just fine and writes a long file with the progress data.
However, the following push doesn't write any data (even when pushing
large data sets to verify progress output happens)

git push origin master --progress > ~/push_error_output.txt 2>&1

As far as I can tell this is a bug with push. =A0I am a bit biased
because I really need this feature, but it seems to me that this is a
fairly large bug because pushing is such a pillar to all things git.

Idea's on work arounds or upcoming patches to fix this?

Thanks
Chase Brammer
