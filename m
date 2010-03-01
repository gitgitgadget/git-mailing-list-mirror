From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: error when installing 1.7.0.1: "ImportError: No module named
 distutils.core"
Date: Mon, 01 Mar 2010 18:21:52 +0000
Message-ID: <bb49d06f73fe23be76e16089ce8b251c@212.159.54.234>
References: <20100301144000.GA17135@cs-wsok.swansea.ac.uk> <be6fef0d1003010715l31d7b49bs36ee69685e1684e8@mail.gmail.com> <fabb9a1e1003010724g7c4d2517v1515b846e288713a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Johan Herland <johan@herland.net>,
	Oliver Kullmann <O.Kullmann@swansea.ac.uk>,
	<git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 01 19:22:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmAFk-0000QK-Hv
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 19:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499Ab0CASVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 13:21:55 -0500
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:52591 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751282Ab0CASVz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Mar 2010 13:21:55 -0500
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 8EBBF819C148;
	Mon,  1 Mar 2010 18:21:53 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 64FC8222D70;
	Mon,  1 Mar 2010 18:21:53 +0000 (GMT)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id yzf2zJBuJg4k; Mon,  1 Mar 2010 18:21:52 +0000 (GMT)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 5D5D31322FA;
	Mon,  1 Mar 2010 18:21:52 +0000 (GMT)
In-Reply-To: <fabb9a1e1003010724g7c4d2517v1515b846e288713a@mail.gmail.com>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141339>

On Mon, 1 Mar 2010 16:24:30 +0100, Sverre Rabbelier <srabbelier@gmail.com>
wrote:
> Heya,
> 
> On Mon, Mar 1, 2010 at 16:15, Tay Ray Chuan <rctay89@gmail.com> wrote:
>> (adding Sverre to the Cc list, perhaps he has something to add)
> 
> This is Johan's code, but IIRC setup.py is pretty much generic
setuptools
> code.
> 
>> you need to install setuptools from python, or pass NO_PYTHON to
>> make/configure.
> 
> Correct.
> 
>>> I've checked the README and INSTALL file, but I don't see that there
>>> are new
>>> requirements? (That is not regarding doc.)
>>
>> I guess we should improve on this.
> 
> Aye, at the very least we need to document this requirement, but it
> would probably be even better to test for the existence of setuptools
> and give a useful error message if it's not found?

Something like the following in the Makefile perhaps?

  Python_distutils = $(shell sh -c "$(PYTHON_PATH) -c 'import distutils'
2>/dev/null || echo not")

  ifeq ($(Python_distutils),not)
          $(warning "Disabling Python: please install setuptools to
enable")
          NO_PYTHON=SadlyYes
  endif

-- 
Julian
