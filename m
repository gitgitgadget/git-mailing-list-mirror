From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/6] Rename get_mode() to decode_tree_mode() and export it
Date: Mon, 4 Oct 2010 21:23:08 -0500
Message-ID: <20101005022308.GD10818@burratino>
References: <4CA86A12.6080905@dbservice.com>
 <1286108511-55876-4-git-send-email-tom@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 04:26:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2xEe-0000vU-0X
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 04:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757091Ab0JEC01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 22:26:27 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:40662 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757009Ab0JEC0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 22:26:25 -0400
Received: by qwh6 with SMTP id 6so3485892qwh.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 19:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bO++cle2yJ9/3PupAOuejdPg5VJ1QmnKBy3oMOkjKNQ=;
        b=RHc04PQXCZucHHqn2eb5xzVliFxbpXahJHHnk/krIXjyOFla8JxVmJ25/Bxtn1U5XQ
         YYcsCjEbnvRN+xxz+wYYdo+ti6vWLOQErpSQ0Tk+OQilBTyX39CvgMBVRNHXBdEouatW
         VaZF1Og3V2x1Ok4FA6xAmL6iyDvVZdqOLs650=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VMM5CLXiub3r/vWhFSofelC01iIP0yM9W7t8eONRfsU/4YFntj8nPbCnnXR2dOgsEj
         tBPapxy9l1UEPRyGgEOvDuNkUfmshI1FWXFu3osH7vawGQ+zmqkhkCQ9zfjjj4lQUxni
         ifDyc2iGTfnAohKyliGCmRoeYsXIq57XTVSzw=
Received: by 10.229.213.20 with SMTP id gu20mr7694520qcb.52.1286245585179;
        Mon, 04 Oct 2010 19:26:25 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id a10sm2451030vci.16.2010.10.04.19.26.23
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 19:26:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286108511-55876-4-git-send-email-tom@dbservice.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158160>

Tomas Carnecky wrote:

> Other sources (fast-import-helper.c) may want to use this function
> to parse trees.

Sounds like a reasonable idea, but you've left out what the function
does.

So:

 get_mode() parses an octal "100644 " string as might
 appear in a tree object.  Returns a pointer to the first
 character after the mode string, or NULL on error.
