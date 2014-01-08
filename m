From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] merge: make merge state available to prepare-commit-msg
 hook
Date: Wed, 8 Jan 2014 12:29:42 -0800
Message-ID: <20140108202942.GM3881@google.com>
References: <6B177FFA-1797-45FE-9EF1-2C9E6EE8A234@yaauie.com>
 <DA9E6645-82DC-4714-845F-423726F96A40@yaauie.com>
 <vpqr48ip7bm.fsf@anie.imag.fr>
 <B19C65C1-C2D9-486F-AEA7-1497A3B5C5B4@yaauie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Ryan Biesemeyer <ryan@yaauie.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 21:30:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0zlM-0003dr-58
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 21:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757433AbaAHU3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 15:29:51 -0500
Received: from mail-gg0-f173.google.com ([209.85.161.173]:38754 "EHLO
	mail-gg0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757236AbaAHU3q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 15:29:46 -0500
Received: by mail-gg0-f173.google.com with SMTP id q4so532519ggn.18
        for <git@vger.kernel.org>; Wed, 08 Jan 2014 12:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8HXnCeLK+6XIs0aD4itx1swcbeBDCo806mwoPGXRDsk=;
        b=qkssWnyhoh55gv854p+B+iyfzLjH8B5AAqD1fwhfMZeNMIpdDzXjh9teeuzrsC17px
         OzlaJPFZesxDpDOa2stZvz7/H+XhPIc9dP58Akyi8xbx21kG6S/mDEiY2zpEWfTdkGFa
         ivovBFK1HbfQGCehKN2lAm3wVxKj5S3rOrgW6pZrarRpkYjo/ADVdE43HJLstxeS25KD
         VG3tYGSAn9WaGTm5ry1Igo4EwHEt9/zclnulUd9qkxpShcajZvRKUKpdyHIZG2ic784J
         xQrb6u8+L94tn2ZD8ghFVwc15bStMML/ZjnODchtBRFyvLshsE/KYQbvBMOwAQHlG43G
         JWLQ==
X-Received: by 10.236.160.9 with SMTP id t9mr89532966yhk.10.1389212986305;
        Wed, 08 Jan 2014 12:29:46 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id e50sm2986935yhd.26.2014.01.08.12.29.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 Jan 2014 12:29:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <B19C65C1-C2D9-486F-AEA7-1497A3B5C5B4@yaauie.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240226>

Hi,

Ryan Biesemeyer wrote:

> In this case it was not immediately clear to me how to add cleanup to an existing
> test that dirtied the state of the test repository by leaving behind an in-progress
> merge. I see `test_cleanup` defined in the test lib & related functions, but see no
> examples of its use in the test suites. Could you advise? 

test_when_finished pushes a command to be run unconditionally
when the current test assertion finishes.

Thanks,
Jonathan
