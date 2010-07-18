From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: remove duplicate code and not needed break statement
Date: Sun, 18 Jul 2010 13:47:16 -0500
Message-ID: <20100718184716.GD14367@burratino>
References: <1279475399-6081-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Jul 18 20:48:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaYuT-0001bW-E7
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 20:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757082Ab0GRSsQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jul 2010 14:48:16 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34942 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757025Ab0GRSsP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jul 2010 14:48:15 -0400
Received: by iwn7 with SMTP id 7so3837564iwn.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 11:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KXp1nj+deUi9YjU4sMqAoyWvjkmvR6oEFwLMEkxWOSY=;
        b=dgsbsDRBvWLkfGb7GqLu62ZAgUyYYDRG+k+Gzal5Q7vysoCm3vVU1C33ow/QNuHFxG
         xEQZQioZqneNBtZBZc3qDyyvMRg684vLt6fIeEiMLCoWw9vVOj/XJE2g68qiqjBB6slz
         LUIUp2oCT6MZRBAgKLcwHeqju2C3NJS/4ZrJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=bZPtD6Vo0Mn4//DpCImkZ4gMLdhADsfnHp+oF3WuWikWdXjkTHG1ehjTnfEPjmekeq
         6LDxDUZN+tu9RrPOwMwDHSqByFIJFWLmld53CI5gnBX1MwGJyoh23DYbR4SFB5WoO1l+
         RKwa8KxcY1id94kr8v9aZJLQe0/L6Ka5nuIv8=
Received: by 10.231.156.66 with SMTP id v2mr4115350ibw.107.1279478894462;
        Sun, 18 Jul 2010 11:48:14 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id n20sm21125036ibe.23.2010.07.18.11.48.13
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 18 Jul 2010 11:48:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1279475399-6081-1-git-send-email-ralf.thielow@googlemail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151238>

Hi Ralf!

Ralf Thielow wrote:

> Remove duplicate code and not needed break statement.

This looks like a reasonable change, with the nice effect of getting
read_pack_info_file() to almost fit in one screen.

The commit message is not super clear.  I would say:

 Subject: update-server-info: Shorten read_pack_info_file()

 The correct responses to a D and a T line in .git/objects/info/packs
 are the same, so combine their case arms.  In both cases we already
 =E2=80=98goto=E2=80=99 out of the switch so while at it, remove a redu=
ndant =E2=80=98break=E2=80=99
 to avoid yet another line of code.

i.e., impact in the subject line, details in the commit message body.

It is missing a sign-off.  See Documentation/SubmittingPatches for
what that means.

Hope that helps,
Jonathan
