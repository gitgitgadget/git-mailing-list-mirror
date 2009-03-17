From: Marcus Better <marcus@better.se>
Subject: [EGIT] assertion failure when renaming file
Date: Tue, 17 Mar 2009 10:43:52 +0100
Message-ID: <gpnrcv$mla$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 11:36:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjWf1-0002KS-FR
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 11:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756774AbZCQKfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 06:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754902AbZCQKfH
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 06:35:07 -0400
Received: from main.gmane.org ([80.91.229.2]:36531 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753141AbZCQKfG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 06:35:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LjWdT-0003Zu-53
	for git@vger.kernel.org; Tue, 17 Mar 2009 10:35:03 +0000
Received: from 80.169.182.16 ([80.169.182.16])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 10:35:03 +0000
Received: from marcus by 80.169.182.16 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 10:35:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 80.169.182.16
User-Agent: KNode/0.99.01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113455>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I get this assertion failure from the Eclipse plugin 0.4.0.200903110025 whenever I try to rename an untracked file in Eclipse:

!ENTRY org.eclipse.ltk.ui.refactoring 4 4 2009-03-17 10:27:06.399
!MESSAGE null argument:
!STACK 0
org.eclipse.core.runtime.AssertionFailedException: null argument:
	at org.eclipse.core.runtime.Assert.isNotNull(Assert.java:86)
	at org.eclipse.core.runtime.Assert.isNotNull(Assert.java:74)
	at org.spearce.egit.core.GitMoveDeleteHook.<init>(GitMoveDeleteHook.java:37)
	at org.spearce.egit.core.GitProvider.getMoveDeleteHook(GitProvider.java:55)
	at org.eclipse.team.internal.core.MoveDeleteManager.getHookFor(MoveDeleteManager.java:34)
	at org.eclipse.team.internal.core.MoveDeleteManager.moveFile(MoveDeleteManager.java:87)
	at org.eclipse.core.internal.resources.Resource.unprotectedMove(Resource.java:1750)
	at org.eclipse.core.internal.resources.Resource.move(Resource.java:1420)
	at org.eclipse.ltk.core.refactoring.resource.RenameResourceChange.perform(RenameResourceChange.java:124)
	at org.eclipse.ltk.core.refactoring.CompositeChange.perform(CompositeChange.java:278)
	at org.eclipse.ltk.core.refactoring.PerformChangeOperation$1.run(PerformChangeOperation.java:260)
	at org.eclipse.core.internal.resources.Workspace.run(Workspace.java:1800)
	at org.eclipse.ltk.core.refactoring.PerformChangeOperation.executeChange(PerformChangeOperation.java:308)
	at org.eclipse.ltk.internal.ui.refactoring.UIPerformChangeOperation.access$1(UIPerformChangeOperation.java:1)
	at org.eclipse.ltk.internal.ui.refactoring.UIPerformChangeOperation$1.run(UIPerformChangeOperation.java:66)
	at org.eclipse.core.runtime.SafeRunner.run(SafeRunner.java:37)
	at org.eclipse.ltk.internal.ui.refactoring.UIPerformChangeOperation$2.run(UIPerformChangeOperation.java:84)
	at org.eclipse.swt.widgets.RunnableLock.run(RunnableLock.java:35)
	at org.eclipse.swt.widgets.Synchronizer.runAsyncMessages(Synchronizer.java:133)
	at org.eclipse.swt.widgets.Display.runAsyncMessages(Display.java:3378)
	at org.eclipse.swt.widgets.Display.readAndDispatch(Display.java:3036)
	at org.eclipse.jface.operation.ModalContext$ModalContextThread.block(ModalContext.java:173)
	at org.eclipse.jface.operation.ModalContext.run(ModalContext.java:388)
	at org.eclipse.ltk.internal.ui.refactoring.RefactoringWizardDialog2.run(RefactoringWizardDialog2.java:317)
	at org.eclipse.ltk.ui.refactoring.RefactoringWizard.internalPerformFinish(RefactoringWizard.java:558)
	at org.eclipse.ltk.ui.refactoring.UserInputWizardPage.performFinish(UserInputWizardPage.java:154)
	at 
org.eclipse.ltk.ui.refactoring.resource.RenameResourceWizard$RenameResourceRefactoringConfigurationPage.performFinish(RenameResourceWizard.java:119)
	at org.eclipse.ltk.ui.refactoring.RefactoringWizard.performFinish(RefactoringWizard.java:622)
	at org.eclipse.ltk.internal.ui.refactoring.RefactoringWizardDialog2.okPressed(RefactoringWizardDialog2.java:446)
	at org.eclipse.jface.dialogs.Dialog.buttonPressed(Dialog.java:472)
	at org.eclipse.jface.dialogs.Dialog$2.widgetSelected(Dialog.java:624)
	at org.eclipse.swt.widgets.TypedListener.handleEvent(TypedListener.java:228)
	at org.eclipse.swt.widgets.EventTable.sendEvent(EventTable.java:84)
	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1158)
	at org.eclipse.swt.widgets.Display.runDeferredEvents(Display.java:3401)
	at org.eclipse.swt.widgets.Display.readAndDispatch(Display.java:3033)
	at org.eclipse.jface.window.Window.runEventLoop(Window.java:825)
	at org.eclipse.jface.window.Window.open(Window.java:801)
	at org.eclipse.ltk.ui.refactoring.RefactoringWizardOpenOperation$1.run(RefactoringWizardOpenOperation.java:144)
	at org.eclipse.swt.custom.BusyIndicator.showWhile(BusyIndicator.java:70)
	at org.eclipse.ltk.ui.refactoring.RefactoringWizardOpenOperation.run(RefactoringWizardOpenOperation.java:156)
	at org.eclipse.jdt.internal.ui.refactoring.actions.RefactoringStarter.activate(RefactoringStarter.java:37)
	at 
org.eclipse.jdt.internal.corext.refactoring.RefactoringExecutionStarter.startRenameResourceRefactoring(RefactoringExecutionStarter.java:442)
	at org.eclipse.jdt.internal.ui.refactoring.actions.RenameResourceAction.run(RenameResourceAction.java:43)
	at org.eclipse.jdt.ui.actions.RenameAction.run(RenameAction.java:110)
	at org.eclipse.jdt.ui.actions.SelectionDispatchAction.dispatchRun(SelectionDispatchAction.java:274)
	at org.eclipse.jdt.ui.actions.SelectionDispatchAction.run(SelectionDispatchAction.java:250)
	at org.eclipse.jface.action.Action.runWithEvent(Action.java:498)
	at org.eclipse.jface.commands.ActionHandler.execute(ActionHandler.java:119)
	at org.eclipse.core.commands.Command.executeWithChecks(Command.java:476)
	at org.eclipse.core.commands.ParameterizedCommand.executeWithChecks(ParameterizedCommand.java:508)
	at org.eclipse.ui.internal.handlers.HandlerService.executeCommand(HandlerService.java:169)
	at org.eclipse.ui.internal.keys.WorkbenchKeyboard.executeCommand(WorkbenchKeyboard.java:472)
	at org.eclipse.ui.internal.keys.WorkbenchKeyboard.press(WorkbenchKeyboard.java:824)
	at org.eclipse.ui.internal.keys.WorkbenchKeyboard.processKeyEvent(WorkbenchKeyboard.java:882)
	at org.eclipse.ui.internal.keys.WorkbenchKeyboard.filterKeySequenceBindings(WorkbenchKeyboard.java:571)
	at org.eclipse.ui.internal.keys.WorkbenchKeyboard.access$3(WorkbenchKeyboard.java:512)
	at org.eclipse.ui.internal.keys.WorkbenchKeyboard$KeyDownFilter.handleEvent(WorkbenchKeyboard.java:127)
	at org.eclipse.swt.widgets.EventTable.sendEvent(EventTable.java:84)
	at org.eclipse.swt.widgets.Display.filterEvent(Display.java:1436)
	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1157)
	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1182)
	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1167)
	at org.eclipse.swt.widgets.Widget.sendKeyEvent(Widget.java:1194)
	at org.eclipse.swt.widgets.Widget.gtk_key_press_event(Widget.java:698)
	at org.eclipse.swt.widgets.Control.gtk_key_press_event(Control.java:2765)
	at org.eclipse.swt.widgets.Composite.gtk_key_press_event(Composite.java:702)
	at org.eclipse.swt.widgets.Tree.gtk_key_press_event(Tree.java:1920)
	at org.eclipse.swt.widgets.Widget.windowProc(Widget.java:1543)
	at org.eclipse.swt.widgets.Control.windowProc(Control.java:4506)
	at org.eclipse.swt.widgets.Display.windowProc(Display.java:4099)
	at org.eclipse.swt.internal.gtk.OS._gtk_main_do_event(Native Method)
	at org.eclipse.swt.internal.gtk.OS.gtk_main_do_event(OS.java:5792)
	at org.eclipse.swt.widgets.Display.eventProc(Display.java:1177)
	at org.eclipse.swt.internal.gtk.OS._g_main_context_iteration(Native Method)
	at org.eclipse.swt.internal.gtk.OS.g_main_context_iteration(OS.java:1550)
	at org.eclipse.swt.widgets.Display.readAndDispatch(Display.java:3031)
	at org.eclipse.ui.internal.Workbench.runEventLoop(Workbench.java:2384)
	at org.eclipse.ui.internal.Workbench.runUI(Workbench.java:2348)
	at org.eclipse.ui.internal.Workbench.access$4(Workbench.java:2200)
	at org.eclipse.ui.internal.Workbench$5.run(Workbench.java:495)
	at org.eclipse.core.databinding.observable.Realm.runWithDefault(Realm.java:288)
	at org.eclipse.ui.internal.Workbench.createAndRunWorkbench(Workbench.java:490)
	at org.eclipse.ui.PlatformUI.createAndRunWorkbench(PlatformUI.java:149)
	at org.eclipse.ui.internal.ide.application.IDEApplication.start(IDEApplication.java:113)
	at org.eclipse.equinox.internal.app.EclipseAppHandle.run(EclipseAppHandle.java:193)
	at org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.runApplication(EclipseAppLauncher.java:110)
	at org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.start(EclipseAppLauncher.java:79)
	at org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:386)
	at org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:179)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:57)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:616)
	at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:549)
	at org.eclipse.equinox.launcher.Main.basicRun(Main.java:504)
	at org.eclipse.equinox.launcher.Main.run(Main.java:1236)
	at org.eclipse.equinox.launcher.Main.main(Main.java:1212)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkm/cNkACgkQXjXn6TzcAQkRiACgosbIeO1X+5rhgu8HaN4IlPY1
gZkAnjH4YMIefzhsIOt+uoHPhOOFBGLG
=mWTz
-----END PGP SIGNATURE-----
