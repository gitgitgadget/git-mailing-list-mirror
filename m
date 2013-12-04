From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Use mongoose to test smart-http unconditionally?
Date: Wed, 4 Dec 2013 15:28:00 -0800
Message-ID: <20131204232800.GG29959@google.com>
References: <CACsJy8BHnTHRugJoTDGs7h=dF1qQUWyPXYxCU8YsDU57s+5gyg@mail.gmail.com>
 <CAJo=hJuzP=zYsEZvC5ugKaAWPLAcTzmFJxT5PNFKbBEv0ctnDw@mail.gmail.com>
 <20131204184842.GA11024@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 05 00:28:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoLrZ-0007xw-I6
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 00:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756185Ab3LDX2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 18:28:08 -0500
Received: from mail-yh0-f44.google.com ([209.85.213.44]:55418 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641Ab3LDX2F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 18:28:05 -0500
Received: by mail-yh0-f44.google.com with SMTP id f64so12096380yha.17
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 15:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/xqp+X1kk6khBKrdVDAu8HJa1lhW1nLwg+5sjRxtVSo=;
        b=G7mi5HWmPrcLLi+ayrBrcxOXuaFlhRKgUVeFzSOoskmmuWJ1fhYHcWcCasHKWDMqKa
         6Er6/E6wjvL869Rw9AodoZARn1oeP3q42cJvHzUEqc3NcsEyCg3nP8vh7RyctTaTNpEv
         kMbAIA9U7IPWdDkEF4JN5JkXBknUjtGc0QGyupZMt3Cgfpofd6Fx815ITpJEPwx0+5q+
         MUDIy5pZm7c1wm8tOigHys6ZH/N5g4EP3aDSqnrGDVmD8igygQ2N7PpxaQA7rhtqyeYM
         +G7OVuOOA6gtj9Np7EHkmERGOUMFbmimY68AlEArXSowXNi4I3rTIPVSQtwT1y3sbYxH
         vyJg==
X-Received: by 10.236.35.71 with SMTP id t47mr8466738yha.72.1386199684871;
        Wed, 04 Dec 2013 15:28:04 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id o27sm10964876yhb.19.2013.12.04.15.28.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 04 Dec 2013 15:28:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131204184842.GA11024@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238828>

Jeff King wrote:

> I don't know if it is worth all that much effort, though. I suppose it
> could get us more exposure to the httpd tests, but I do not know if it
> would be a good idea to turn them on by default anyway. They touch
> global machine resources (like ports) that can cause conflicts or test
> failures. I assume that is the reason we do not turn on git-daemon tests
> by default

Yup, that's why I don't run them.

For what it's worth, when I build git and run tests I tend to be in an
environment with apache available, but I'm too lazy to configure git's
tests to pick the right port and make sure it is reserved and so on.
Perhaps there's some way to help lazy people in the same boat?  (E.g.,
picking a port randomly and skipping instead of failing a test when
it's taken or something)
